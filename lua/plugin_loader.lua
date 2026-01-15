local M = {}

local RUNTIME_STATE_PATH = vim.fs.joinpath(vim.fn.stdpath("data"), "plugin_state.json")
local PROFILE_STATE_PATH = vim.fs.joinpath(vim.fn.stdpath("config"), "plugin_state.json")

-- ---------------------------------------------------------------------------
-- UTILS
-- ---------------------------------------------------------------------------

local function is_array(t)
    local n = 0
    for k in pairs(t) do
        if type(k) ~= "number" then
            return false
        end
        if k > n then
            n = k
        end
    end
    return n == #t
end

local function escape_string(s)
    return s:gsub("[%z\1-\31\\\"]", function(c)
        return string.format("\\u%04x", c:byte())
    end)
end

local function encode_sorted(value)
    local t = type(value)

    if t == "nil" then
        return "null"
    elseif t == "boolean" then
        return value and "true" or "false"
    elseif t == "number" then
        return tostring(value)
    elseif t == "string" then
        return "\"" .. escape_string(value) .. "\""
    elseif t == "table" then
        if is_array(value) then
            local parts = {}
            for i = 1, #value do
                parts[#parts + 1] = encode_sorted(value[i])
            end
            return "[" .. table.concat(parts, ",") .. "]"
        else
            local keys = {}
            for k in pairs(value) do
                if type(k) ~= "string" then
                    error("JSON object keys must be strings")
                end
                keys[#keys + 1] = k
            end

            table.sort(keys, function(a, b)
                local va = value[a]
                local vb = value[b]

                if type(va) == "boolean" and type(vb) == "boolean" and va ~= vb then
                    return va == true
                end

                -- return a < b
                return a:lower() < b:lower()
            end)

            local parts = {}
            for _, k in ipairs(keys) do
                parts[#parts + 1] = encode_sorted(k) .. ":" .. encode_sorted(value[k])
            end
            return "{" .. table.concat(parts, ",") .. "}"
        end
    end

    error("Unsupported type: " .. t)
end

local function copy_file(src, dst)
    if vim.fn.filereadable(src) ~= 1 then
        return false, "Source file does not exist: " .. src
    end

    local content = vim.fn.readfile(src)
    vim.fn.mkdir(vim.fn.fnamemodify(dst, ":h"), "p")
    vim.fn.writefile(content, dst)

    return true
end

local function resolve_destination(path, file_name)
    if vim.fn.isdirectory(path) == 1 then
        return vim.fs.joinpath(path, file_name)
    end
    return path
end

local function build_header(width, rows, placement)
    local sep = "│"
    local deco_sep = ((placement == "bottom") and "┬") or "┴"
    local margin = 2

    local lk, ld, rk, rd = 0, 0, 0, 0
    for _, r in ipairs(rows) do
        lk = math.max(lk, #r[1])
        ld = math.max(ld, #r[2])
        rk = math.max(rk, #r[3])
        rd = math.max(rd, #r[4])
    end

    local fixed = 5
    local min_required = lk + ld + rk + rd + fixed + margin * 2

    if width < min_required then
        return {}
    end

    local extra = width - min_required
    local extra_left = math.floor(extra / 2)
    local e_l_1 = math.floor(extra_left / 2)
    local e_l_2 = extra_left - e_l_1
    local extra_right = extra - extra_left
    local e_r_1 = math.floor(extra_right / 2)
    local e_r_2 = extra_right - e_r_1

    local lines = {}

    local deco_left = math.floor((width - 1) / 2)
    local deco_right = width - deco_left - 1
    table.insert(lines, string.rep("─", deco_left) .. deco_sep .. string.rep("─", deco_right))

    local pad = string.rep(" ", margin)

    for _, r in ipairs(rows) do
        local left = string.format(
            "%-" .. (lk + e_l_1) .. "s %-" .. (ld + e_l_2) .. "s",
            pad .. string.rep(" ", math.floor((lk - #r[1]) / 2)) .. r[1],
            pad .. r[2]
        )

        local right = string.format(
            "%-" .. (rk + e_r_1) .. "s %-" .. (rd + e_r_2) .. "s",
            pad .. string.rep(" ", math.floor((rk - #r[3]) / 2)) .. r[3],
            pad .. r[4]
        )

        table.insert(lines, left .. sep .. right)
    end

    return lines
end

-- ---------------------------------------------------------------------------
-- SECTION TYPE DEFINITIONS
-- ---------------------------------------------------------------------------

local section_types = {
    multiselect = {
        render = function(option, is_selected)
            local icon = is_selected and "🟢" or "🔴"
            return string.format("  %s %s", icon, option.label)
        end,

        toggle = function(state, option_id)
            local new_state = vim.deepcopy(state)
            if state[option_id] == true then
                new_state[option_id] = false
            else
                new_state[option_id] = true
            end
            return new_state
        end,

        validate = function(state)
            return true
        end,
    },

    singleselect = {
        render = function(option, is_selected)
            local icon = is_selected and "🟢" or "🔴"
            return string.format("  %s %s", icon, option.label)
        end,

        toggle = function(state, option_id)
            local new_state = {}
            new_state[option_id] = true
            return new_state
        end,

        validate = function(state)
            local count = 0
            for _, v in pairs(state) do
                if v then
                    count = count + 1
                end
            end
            return count == 1
        end,
    },
}

-- ---------------------------------------------------------------------------
-- PERSISTENCE LAYER
-- ---------------------------------------------------------------------------

local Persistence = {}

function Persistence.load(filepath)
    local file = io.open(filepath, "r")
    if not file then
        return nil
    end

    local content = file:read("*all")
    file:close()

    if content == "" then
        return nil
    end

    local ok, decoded = pcall(vim.json.decode, content)
    if ok then
        return decoded
    end

    return nil
end

function Persistence.save(filepath, state_data)
    local dir = vim.fn.fnamemodify(filepath, ":h")
    vim.fn.mkdir(dir, "p")

    local file = io.open(filepath, "w")
    if not file then
        return false, "Cannot write to file"
    end

    -- file:write(vim.json.encode(state_data))
    file:write(encode_sorted(state_data))
    file:close()

    return true
end

-- ---------------------------------------------------------------------------
-- STATE MANAGER
-- ---------------------------------------------------------------------------

local State = {}
State.__index = State

function State.new(menu_config, initial_state)
    local self = setmetatable({}, State)
    self.sections = {}
    self.listeners = {}
    self.config = menu_config

    for _, section in ipairs(menu_config.sections) do
        local selection = {}
        if initial_state and initial_state[section.id] then
            selection = initial_state[section.id]
        end

        self.sections[section.id] = {
            type = section.type,
            options = section.options,
            selection = selection,
        }
    end

    return self
end

function State:get_section(section_id)
    return self.sections[section_id]
end

function State:toggle_option(section_id, option_id)
    local section = self.sections[section_id]
    local section_type = section_types[section.type]

    section.selection = section_type.toggle(section.selection, option_id)
    self:_notify_change()
end

function State:get_selected(section_id)
    local section = self.sections[section_id]
    local selected = {}

    for option_id, is_selected in pairs(section.selection) do
        if is_selected then
            table.insert(selected, option_id)
        end
    end

    return selected
end

function State:on_change(callback)
    table.insert(self.listeners, callback)
end

function State:_notify_change()
    for _, callback in ipairs(self.listeners) do
        callback()
    end
end

function State:export()
    local exported = {}

    for section_id, section_data in pairs(self.sections) do
        exported[section_id] = {}

        if self.config.save_mode == "enabled_only" then
            for option_id, enabled in pairs(section_data.selection) do
                if enabled then
                    exported[section_id][option_id] = true
                end
            end
        elseif self.config.save_mode == "touched" then
            for id, v in pairs(section_data.selection) do
                exported[section_id][id] = v
            end
        elseif self.config.save_mode == "all" then
            for _, option in ipairs(section_data.options) do
                exported[section_id][option.id] = section_data.selection[option.id] == true
            end
        end
    end

    return exported
end

function State:is_enabled(section_id, option_id)
    local section = self.sections[section_id]
    if not section then
        return false
    end
    return section.selection[option_id] == true
end

function State:get_all_enabled()
    local enabled = {}
    for section_id, _ in pairs(self.sections) do
        enabled[section_id] = self:get_selected(section_id)
    end
    return enabled
end

-- ---------------------------------------------------------------------------
-- RENDERER
-- ---------------------------------------------------------------------------

local Renderer = {}
Renderer.__index = Renderer

function Renderer.new(state, config)
    local self = setmetatable({}, Renderer)
    self.state = state
    self.config = config
    self.buf = nil
    self.win = nil
    self.line_map = {}
    return self
end

function Renderer:render()
    if not self.buf or not vim.api.nvim_buf_is_valid(self.buf) then
        self:_create_window()
    end

    self:_update_content()
end

function Renderer:_create_window()
    self.buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(self.buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(self.buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(self.buf, "modifiable", false)

    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    self.win = vim.api.nvim_open_win(self.buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.api.nvim_win_set_option(self.win, "wrap", false)
end

function Renderer:_update_content()
    local lines = {}
    self.line_map = {}
    local current_line = 0

    for _, section_config in ipairs(self.config.sections) do
        local section = self.state:get_section(section_config.id)
        local section_type = section_types[section.type]

        local enabled_count = 0
        local total_count = #section.options
        for _, is_enabled in pairs(section.selection) do
            if is_enabled then
                enabled_count = enabled_count + 1
            end
        end

        local header = string.format("(%d/%d) %s", enabled_count, total_count, section_config.title)
        table.insert(lines, header)
        current_line = current_line + 1

        local sorted_options = {}
        for _, option in ipairs(section.options) do
            local is_selected = section.selection[option.id] or false
            table.insert(sorted_options, {
                option = option,
                is_selected = is_selected,
            })
        end

        table.sort(sorted_options, function(a, b)
            if a.is_selected ~= b.is_selected then
                return a.is_selected
            end
            return a.option.label < b.option.label
        end)

        for _, item in ipairs(sorted_options) do
            local line_text = section_type.render(item.option, item.is_selected)
            table.insert(lines, line_text)

            current_line = current_line + 1
            self.line_map[current_line] = {
                section_id = section_config.id,
                option_id = item.option.id,
            }
        end

        table.insert(lines, "")
        current_line = current_line + 1
    end

    local header_lines = build_header(vim.o.columns * 0.6, {
        { "<Enter>/<Space>", "Toggle", "r", "Delete config" },
        { "i", "Import", "e", "Export" },
        { "q", "Save & Quit", "<Esc>", "Quit w/o saving" },
    }, "bottom")

    for i = 1, #header_lines, 1 do
        table.insert(lines, header_lines[i])
    end

    vim.api.nvim_buf_set_option(self.buf, "modifiable", true)
    vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(self.buf, "modifiable", false)
end

function Renderer:get_item_at_cursor()
    local line = vim.api.nvim_win_get_cursor(self.win)[1]
    return self.line_map[line]
end

function Renderer:close()
    if self.win and vim.api.nvim_win_is_valid(self.win) then
        vim.api.nvim_win_close(self.win, true)
    end
    if self.buf and vim.api.nvim_buf_is_valid(self.buf) then
        vim.api.nvim_buf_delete(self.buf, { force = true })
    end
end

-- ---------------------------------------------------------------------------
-- INPUT HANDLER
-- ---------------------------------------------------------------------------

local function setup_keymaps(buf, renderer, state, on_submit, config)
    local function toggle_current()
        local item = renderer:get_item_at_cursor()
        if item then
            state:toggle_option(item.section_id, item.option_id)
        end
    end

    local function submit()
        if config.state_file then
            local exported = state:export()
            local ok, err = Persistence.save(config.state_file, exported)
            if ok then
                vim.notify("[PluginLoader] Configuration saved! (" .. config.state_file .. ")", vim.log.levels.INFO)
            else
                vim.notify("[PluginLoader] Save failed (" .. config.state_file .. "): " .. err, vim.log.levels.ERROR)
            end
        end

        renderer:close()
        if on_submit then
            on_submit(state:get_all_enabled())
        end
    end

    local function quit()
        renderer:close()
    end

    local opts = { noremap = true, silent = true, buffer = buf }
    local disable_keys = { "I", "a", "A", "o", "O", "s", "S", "v", "V", "<C-v>", ":" }
    for _, key in ipairs(disable_keys) do
        vim.keymap.set("n", key, "<nop>", opts)
    end

    vim.keymap.set("n", "<CR>", toggle_current, opts)
    vim.keymap.set("n", "<Space>", toggle_current, opts)
    vim.keymap.set("n", "q", submit, opts)
    vim.keymap.set("n", "c", quit, opts)
    vim.keymap.set("n", "<Esc>", quit, opts)
    vim.keymap.set("n", "r", "<Cmd>PluginLoaderReset<CR>", opts)
    vim.keymap.set("n", "e", "<Cmd>PluginLoaderExport<CR>", opts)
    vim.keymap.set("n", "i", "<Cmd>PluginLoaderImport<CR>", opts)
end

-- ---------------------------------------------------------------------------
-- PLUGIN INTEGRATION
-- ---------------------------------------------------------------------------

local function deep_merge(t1, t2)
    local result = vim.deepcopy(t1)
    for k, v in pairs(t2) do
        if type(v) == "table" and type(result[k]) == "table" then
            result[k] = deep_merge(result[k], v)
        else
            result[k] = v
        end
    end
    return result
end

function M.populate_lazy_plugins(state)
    local plugins = {}

    -- Load themes
    local ok_themes, themes_module = pcall(require, "plugins.themes")
    if ok_themes then
        for plugin_name, plugin_config in pairs(themes_module) do
            local is_enabled = state:is_enabled("themes", plugin_name)

            local merged = deep_merge({}, plugin_config)
            merged.cond = is_enabled
            if is_enabled then
                merged.lazy = false
                merged.priority = 1000
            end

            table.insert(plugins, deep_merge({ plugin_name }, merged))
        end
    end

    -- Load regular plugins
    local ok_plugins, plugins_module = pcall(require, "plugins.init")
    if ok_plugins then
        for plugin_name, plugin_config in pairs(plugins_module) do
            local is_enabled = state:is_enabled("plugins", plugin_name)

            local merged = deep_merge({ cond = is_enabled }, plugin_config)
            table.insert(plugins, deep_merge({ plugin_name }, merged))
        end
    end

    return plugins
end

function M.ensure_lazy_installed()
    if pcall(require, "lazy") then
        return
    end

    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if vim.loop.fs_stat(lazypath) then
        vim.opt.rtp:prepend(lazypath)
        return
    end

    if vim.fn.executable("git") ~= 1 then
        vim.notify("git not found in PATH; cannot install lazy.nvim", vim.log.levels.ERROR)
        return
    end

    vim.notify("[PluginLoader] Installing lazy.nvim...", vim.log.levels.INFO)

    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end

    vim.opt.rtp:prepend(lazypath)
end

-- ---------------------------------------------------------------------------
-- PUBLIC API
-- ---------------------------------------------------------------------------

M._state = nil
M._config = nil

function M.open_menu(config, on_submit)
    local initial_state = nil

    config = config or M._config

    if config.state_file then
        local loaded, err = Persistence.load(config.state_file)
        if loaded then
            initial_state = loaded
        end
    end

    local state = State.new(config, initial_state)
    M._state = state
    M._config = config

    local renderer = Renderer.new(state, config)

    state:on_change(function()
        renderer:render()
    end)

    renderer:render()
    setup_keymaps(renderer.buf, renderer, state, on_submit, config)
end

function M.is_enabled(section_id, option_id)
    if not M._state then
        if M._config and M._config.state_file then
            local loaded = Persistence.load(M._config.state_file)
            if loaded and loaded[section_id] then
                return loaded[section_id][option_id] == true
            end
        end
        return false
    end
    return M._state:is_enabled(section_id, option_id)
end

function M.get_enabled()
    if not M._state then
        if M._config and M._config.state_file then
            return Persistence.load(M._config.state_file) or {}
        end
        return {}
    end
    return M._state:get_all_enabled()
end

function M.load_state(config)
    M._config = config

    local loaded = {}
    if config.state_file then
        local persisted = Persistence.load(config.state_file)
        if persisted then
            loaded = persisted
        end
    end

    M._state = State.new(config, loaded)

    return true
end

-- ---------------------------------------------------------------------------
-- INITIALIZATION
-- ---------------------------------------------------------------------------

function M.build_menu_config(state_file)
    local plugin_options = {}
    local theme_options = {}

    local ok_plugins, plugins_module = pcall(require, "plugins.init")
    if ok_plugins then
        for plugin_name, _ in pairs(plugins_module) do
            table.insert(plugin_options, { id = plugin_name, label = plugin_name })
        end
    end

    local ok_themes, themes_module = pcall(require, "plugins.themes")
    if ok_themes then
        for theme_name, _ in pairs(themes_module) do
            table.insert(theme_options, { id = theme_name, label = theme_name })
        end
    end

    table.sort(plugin_options, function(a, b)
        return a.id < b.id
    end)
    table.sort(theme_options, function(a, b)
        return a.id < b.id
    end)

    return {
        state_file = state_file,
        save_mode = "all",
        sections = {
            {
                id = "plugins",
                title = "Plugins",
                type = "multiselect",
                options = plugin_options,
            },
            {
                id = "themes",
                title = "Themes",
                type = "singleselect",
                options = theme_options,
            },
        },
    }
end

function M.start()
    local config = M._config
    if not config then
        local config_path = RUNTIME_STATE_PATH
        config = M.build_menu_config(config_path)
        M._config = config
    end

    M.ensure_lazy_installed()
    M.load_state(config)

    local plugins = M.populate_lazy_plugins(M._state)
    require("lazy").setup(plugins, {
        checker = { enabled = false },
    })
end

function M.setup(opts)
    opts = opts or {}

    local config_path = opts.config_path or RUNTIME_STATE_PATH
    local config = M.build_menu_config(config_path)
    M._config = config

    vim.api.nvim_create_user_command("PluginLoader", function()
        M.open_menu(config, function(result)
            vim.notify("[PluginLoader] Restart Neovim to apply changes", vim.log.levels.INFO)
        end)
    end, { desc = "Open plugin loader menu" })

    vim.api.nvim_create_user_command("PluginLoaderReset", function()
        local state_path = resolve_destination(RUNTIME_STATE_PATH, "plugin_state.json")

        if vim.fn.filereadable(state_path) ~= 1 then
            vim.notify("[PluginLoader] No runtime state to reset.", vim.log.levels.INFO)
            return
        end

        local confirm =
            vim.fn.confirm(("Reset plugin loader state?\n\nThis will delete:\n%s\n"):format(state_path), "&Yes\n&No", 2)

        if confirm ~= 1 then
            return
        end

        vim.fn.delete(state_path)

        vim.notify("[PluginLoader] Runtime plugin state cleared. Restart Neovim.", vim.log.levels.WARN)
    end, {
        desc = "Delete local plugin loader runtime state",
    })

    vim.api.nvim_create_user_command("PluginLoaderExport", function(opts)
        local src = RUNTIME_STATE_PATH
        local dst = resolve_destination(opts.args ~= "" and opts.args or PROFILE_STATE_PATH, "plugin_state.json")

        local confirm = vim.fn.confirm(("Export plugin state?\n\n%s -> %s\n"):format(src, dst), "&Yes\n&No", 2)

        if confirm ~= 1 then
            return
        end

        local ok, err = copy_file(src, dst)
        if not ok then
            vim.notify("[PluginLoader] Export failed: " .. err, vim.log.levels.ERROR)
            return
        end

        vim.notify("[PluginLoader] Exported plugin state:\n" .. dst, vim.log.levels.INFO)
    end, {
        desc = "Export plugin loader state (data → config or path)",
        nargs = "?",
        complete = "file",
    })

    vim.api.nvim_create_user_command("PluginLoaderImport", function(opts)
        local src = resolve_destination(opts.args ~= "" and opts.args or PROFILE_STATE_PATH, "plugin_state.json")
        local dst = resolve_destination(RUNTIME_STATE_PATH, "plugin_state.json")

        local confirm = vim.fn.confirm(("Import plugin state?\n\n%s -> %s\n"):format(src, dst), "&Yes\n&No", 2)

        if confirm ~= 1 then
            return
        end

        local ok, err = copy_file(src, dst)
        if not ok then
            vim.notify("[PluginLoader] Import failed: " .. err, vim.log.levels.ERROR)
            return
        end

        vim.notify("[PluginLoader] Imported plugin state. Restart Neovim.", vim.log.levels.WARN)
    end, {
        desc = "Import plugin loader state (config/path → data)",
        nargs = "?",
        complete = "file",
    })
end

return M
