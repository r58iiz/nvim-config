local Rule = require("custom.lib.renumber.rule")
local engine = require("custom.lib.renumber.engine")

local function ensure_highlights()
    vim.api.nvim_set_hl(0, "RenumberMatch", { link = "Search", default = true })
    vim.api.nvim_set_hl(0, "RenumberResult", { link = "DiffAdd", default = true })
    vim.api.nvim_set_hl(0, "RenumberError", { link = "ErrorMsg", default = true })
    vim.api.nvim_set_hl(0, "RenumberLabel", { link = "Label", default = true })
    vim.api.nvim_set_hl(0, "RenumberHint", { link = "Comment", default = true })
end

local function debounce(fn, ms)
    local timer = vim.loop.new_timer()
    return function(...)
        local args = { ... }
        timer:stop()
        timer:start(
            ms,
            0,
            vim.schedule_wrap(function()
                fn(unpack(args))
            end)
        )
    end
end

local function pad_right(s, w)
    return s .. string.rep(" ", math.max(0, w - #s))
end

local function center(s, w)
    local p = math.max(0, math.floor((w - #s) / 2))
    return string.rep(" ", p) .. s
end

-- components

local function make_title(text)
    return {
        rows = function(_, W)
            return {
                { text = center("── " .. text .. " ──", W) },
                { text = "" },
            }
        end,
    }
end

local function make_divider()
    return {
        rows = function(_, W)
            return {
                { text = "" },
                { text = string.rep("─", W) },
                { text = "" },
            }
        end,
    }
end

local function make_spacer()
    return {
        rows = function()
            return { { text = "" } }
        end,
    }
end

local function make_field(f, focused)
    return {
        rows = function(_, W)
            local cursor = focused and "▸ " or "  "
            local label = pad_right(cursor .. f.label, 12)
            local val = f.value .. (focused and "▌" or "")
            return {
                { text = pad_right(label .. val, W), hl = focused and "RenumberLabel" or nil },
            }
        end,
    }
end

local function make_choice_field(f, focused)
    return {
        rows = function(_, W)
            local cursor = focused and "▸ " or "  "
            local label = pad_right(cursor .. f.label, 12)
            local row = label
            for _, ch in ipairs(f.choices) do
                row = row .. (ch == f.value and ("[" .. ch .. "] ") or (" " .. ch .. "  "))
            end
            return {
                { text = pad_right(row, W), hl = focused and "RenumberLabel" or nil },
            }
        end,
    }
end

local function make_preview(preview, error, height)
    return {
        rows = function(_, W)
            local col_sep = math.floor(W * 0.5)
            local out = {}
            local matched = 0

            if #preview == 0 and not error then
                table.insert(out, { text = pad_right("  (enter a pattern to preview)", W) })
            else
                for _, row in ipairs(preview) do
                    if row.matched then
                        matched = matched + 1
                    end
                    local indicator = row.matched and "●" or "·"
                    local orig = pad_right(row.original, col_sep - 4)
                    local hl = row.matched and (row.original ~= row.result and "RenumberResult" or "RenumberMatch")
                        or nil
                    table.insert(out, {
                        text = pad_right(string.format("  %s  %s→  %s", indicator, orig, row.result), W),
                        hl = hl,
                    })
                end
            end

            -- pad to reserved height
            while #out < height do
                table.insert(out, { text = "" })
            end

            return out, matched
        end,
    }
end

local function make_status(matched_count, error)
    return {
        rows = function(_, W)
            local err = error and ("error: " .. error) or ""
            local text = pad_right("  matched: " .. matched_count .. "   " .. err, W)
            return {
                { text = text, hl = error and "RenumberError" or nil },
            }
        end,
    }
end

local function make_buttons(focused_idx)
    return {
        rows = function(_, W)
            local apply = (focused_idx == 1) and "[  Apply  ]" or "   Apply   "
            local cancel = (focused_idx == 2) and "[  Cancel  ]" or "   Cancel   "
            return {
                { text = pad_right("  " .. apply .. "    " .. cancel, W) },
            }
        end,
    }
end

local function make_footer(keybinds)
    return {
        rows = function(_, W)
            local parts = {}
            for _, kb in ipairs(keybinds) do
                table.insert(parts, kb.key .. " " .. kb.desc)
            end
            local hint = table.concat(parts, "  ·  ")
            if #hint > W - 2 then
                hint = hint:sub(1, W - 5) .. "…"
            end
            return {
                { text = "  " .. hint, hl = "RenumberHint" },
            }
        end,
    }
end

-- render

local function render(buf, components, W)
    vim.bo[buf].modifiable = true

    local text_lines = {}
    local hl_list = {} -- { lnum (0-based), group }

    for _, comp in ipairs(components) do
        local rows = comp:rows(W)
        for _, row in ipairs(rows) do
            local lnum = #text_lines
            table.insert(text_lines, pad_right(row.text or "", W))
            if row.hl then
                table.insert(hl_list, { lnum = lnum, group = row.hl })
            end
        end
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, text_lines)
    vim.bo[buf].modifiable = false

    local ns = vim.api.nvim_create_namespace("renumber_form")
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    for _, h in ipairs(hl_list) do
        vim.api.nvim_buf_add_highlight(buf, ns, h.group, h.lnum, 0, -1)
    end
end

-- state

local State = {}
State.__index = State

function State.new(source_lines)
    return setmetatable({
        source_lines = source_lines,
        fields = {
            { name = "pattern", label = "Pattern", value = "", editable = true },
            { name = "type", label = "Type", value = "vim", editable = false, choices = { "vim", "lua" } },
            { name = "step", label = "Step", value = "1", editable = true },
            { name = "pad", label = "Pad", value = "0", editable = true },
        },
        focus = 1,
        error = nil,
        preview = {},
        matched = 0,
    }, State)
end

function State:total_focuses()
    return #self.fields + 2 -- +Apply +Cancel
end

function State:focused_field()
    return self.fields[self.focus]
end

function State:get(name)
    for _, f in ipairs(self.fields) do
        if f.name == name then
            return f.value
        end
    end
end

function State:build_rule()
    local pattern = self:get("pattern")
    if pattern == "" then
        return nil, "pattern is empty"
    end

    local is_vim = (self:get("type") == "vim")
    local step = tonumber(self:get("step")) or 1
    local pad = tonumber(self:get("pad")) or 0
    if step == 0 then
        step = 1
    end

    local ok, rule = pcall(Rule.new, {
        name = "form",
        pattern = pattern,
        pad = pad,
        is_vim_regex = is_vim,
    })
    if not ok then
        return nil, tostring(rule)
    end
    return rule, nil, step
end

function State:refresh_preview(preview_rows)
    local rule, err, step = self:build_rule()
    self.error = err
    self.preview = {}
    self.matched = 0
    if not rule then
        return
    end

    local slice = {}
    for i = 1, math.min(preview_rows, #self.source_lines) do
        slice[i] = self.source_lines[i]
    end

    local ok, result = pcall(engine.apply, slice, { rule }, { step = step })
    if not ok then
        self.error = tostring(result)
        return
    end

    local count = 0
    for i, orig in ipairs(slice) do
        local matched = rule:line_has_match(orig)
        if matched then
            count = count + 1
        end
        table.insert(self.preview, { original = orig, result = result[i], matched = matched })
    end
    self.matched = count
end

-- build components

local function build_components(state, keybinds, preview_rows)
    local n = #state.fields
    local comps = {}

    table.insert(comps, make_title("Renumber"))

    for i, f in ipairs(state.fields) do
        local focused = (state.focus == i)
        if f.choices then
            table.insert(comps, make_choice_field(f, focused))
        else
            table.insert(comps, make_field(f, focused))
        end
    end

    table.insert(comps, make_divider())
    table.insert(comps, make_preview(state.preview, state.error, preview_rows))
    table.insert(comps, make_spacer())
    table.insert(comps, make_status(state.matched, state.error))
    table.insert(comps, make_spacer())

    local btn_focus = state.focus == n + 1 and 1 or state.focus == n + 2 and 2 or nil
    table.insert(comps, make_buttons(btn_focus))

    table.insert(comps, make_spacer())
    table.insert(comps, make_footer(keybinds))

    return comps
end

local function measure_fixed_rows(state, keybinds)
    local dummy_comps = build_components(state, keybinds, 0)
    local total = 0
    for _, comp in ipairs(dummy_comps) do
        local rows = comp:rows(80) -- W doesn't affect row count
        total = total + #rows
    end
    return total
end

-- run

local function open_form(source_lines, on_apply)
    ensure_highlights()

    local W = math.floor(vim.o.columns * 0.8)
    local H = math.floor(vim.o.lines * 0.8)
    local state = State.new(source_lines)

    local keybinds = {}

    local fixed = measure_fixed_rows(state, keybinds)
    local prev_rows = math.max(1, H - fixed)

    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].filetype = "renumber_form"

    local function do_render()
        local comps = build_components(state, keybinds, prev_rows)
        render(buf, comps, W)
    end

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = W,
        height = H,
        row = math.floor((vim.o.lines - H) / 2),
        col = math.floor((vim.o.columns - W) / 2),
        style = "minimal",
        border = "rounded",
        title = " Renumber ",
        title_pos = "center",
        noautocmd = true,
    })

    vim.wo[win].cursorline = false
    vim.wo[win].number = false
    vim.wo[win].signcolumn = "no"

    local refresh_preview = debounce(function()
        state:refresh_preview(prev_rows)
        do_render()
    end, 120)

    -- actions

    local function close()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end

    local function apply()
        local rule, err, step = state:build_rule()
        if err then
            state.error = err
            do_render()
            return
        end
        close()
        on_apply({ rules = { rule }, step = step })
    end

    local function feed_char(ch)
        local f = state:focused_field()
        if not f or not f.editable then
            return
        end
        f.value = f.value .. ch
        refresh_preview()
    end

    local function backspace()
        local f = state:focused_field()
        if not f or not f.editable then
            return
        end
        f.value = f.value:sub(1, -2)
        refresh_preview()
    end

    local function tab_next()
        state.focus = state.focus + 1
        if state.focus > state:total_focuses() then
            state.focus = 1
        end
        do_render()
    end

    local function tab_prev()
        state.focus = state.focus - 1
        if state.focus < 1 then
            state.focus = state:total_focuses()
        end
        do_render()
    end

    local function enter()
        if state.focus == #state.fields + 1 then
            apply()
        elseif state.focus == #state.fields + 2 then
            close()
        else
            local f = state:focused_field()
            if f and f.choices then
                local idx = 1
                for i, ch in ipairs(f.choices) do
                    if ch == f.value then
                        idx = i
                        break
                    end
                end
                f.value = f.choices[(idx % #f.choices) + 1]
                refresh_preview()
            else
                tab_next()
            end
        end
    end

    local function space_toggle()
        local f = state:focused_field()
        if f and f.choices then
            enter()
        else
            feed_char(" ")
        end
    end

    -- keymap helpers

    local function map(key, fn, desc)
        vim.keymap.set("n", key, fn, { buffer = buf, nowait = true, silent = true })
        if desc then
            table.insert(keybinds, { key = key, desc = desc })
        end
    end

    local function map_silent(key, fn)
        vim.keymap.set("n", key, fn, { buffer = buf, nowait = true, silent = true })
    end

    local noop = function() end

    -- Named keys (appear in footer)
    map("<Tab>", tab_next, "next")
    map("<S-Tab>", tab_prev, "prev")
    map("<CR>", enter, "confirm")
    map("<Space>", space_toggle, "cycle")
    map("<BS>", backspace, "delete")
    map("<Esc>", close, "cancel")
    map("q", close, "quit")

    -- Arrow keys: silently disabled
    map_silent("<Up>", noop)
    map_silent("<Down>", noop)
    map_silent("<Left>", noop)
    map_silent("<Right>", noop)

    for byte = 32, 126 do
        local ch = string.char(byte)
        if ch ~= " " and ch ~= "q" then
            map_silent(ch, function()
                feed_char(ch)
            end)
        end
    end

    -- recompute fixed rows
    fixed = measure_fixed_rows(state, keybinds)
    prev_rows = math.max(1, H - fixed)

    -- initial draw
    state:refresh_preview(prev_rows)
    do_render()

    vim.api.nvim_win_set_cursor(win, { 1, 0 })
    vim.cmd("startinsert")
    vim.cmd("stopinsert")
end

return { open = open_form }
