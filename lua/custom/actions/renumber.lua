local Rule = require("custom.lib.renumber.rule")
local engine = require("custom.lib.renumber.engine")
local form_mod = require("custom.lib.renumber.form")
local parse_args = require("custom.lib.renumber.parse_args")

local M = {}

function M.run(opts)
    opts = opts or {}

    local bufnr = 0
    local first = opts.first or vim.fn.line("'<")
    local last = opts.last or vim.fn.line("'>")

    if first > last then
        vim.notify("Renumber: invalid range", vim.log.levels.ERROR)
        return
    end

    local rules = opts.rules or {}
    if #rules == 0 then
        vim.notify("Renumber: no rules supplied", vim.log.levels.WARN)
        return
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, first - 1, last, false)
    local new_lines = engine.apply(lines, rules, { step = opts.step })

    vim.api.nvim_buf_set_lines(bufnr, first - 1, last, false, new_lines)

    local changed = 0
    for i, l in ipairs(new_lines) do
        if l ~= lines[i] then
            changed = changed + 1
        end
    end
    vim.notify(("Renumber: %d line(s) updated"):format(changed), vim.log.levels.INFO)
end

function M.command(cmd)
    local parsed, err = parse_args(cmd.args, cmd.line1, cmd.line2)
    if err then
        vim.notify("Renumber: " .. err, vim.log.levels.ERROR)
        return
    end

    local ok, rule = pcall(Rule.new, {
        name = "cmd",
        pattern = parsed.pattern,
        pad = parsed.pad,
        is_vim_regex = parsed.is_vim_regex,
    })
    if not ok then
        vim.notify("Renumber: bad pattern — " .. tostring(rule), vim.log.levels.ERROR)
        return
    end

    M.run({
        rules = { rule },
        step = parsed.step,
        first = parsed.first,
        last = parsed.last,
    })
end

function M.form(opts)
    opts = opts or {}

    local bufnr = 0
    local first = opts.first or vim.fn.line("'<")
    local last = opts.last or vim.fn.line("'>")

    if first > last then
        vim.notify("Renumber: invalid range — make a visual selection first", vim.log.levels.WARN)
        return
    end

    local source_lines = vim.api.nvim_buf_get_lines(bufnr, first - 1, last, false)

    form_mod.open(source_lines, function(result)
        M.run({
            rules = result.rules,
            step = result.step,
            first = first,
            last = last,
        })
    end)
end

return M
