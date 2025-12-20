local Rule = require("custom.lib.renumber.rule")
local engine = require("custom.lib.renumber.engine")

local M = {}

local function prompt_rules()
    local rules = {}

    while true do
        local name = vim.fn.input("Rule name (empty to finish): ")
        if name == "" then
            break
        end

        local pattern = vim.fn.input("Regex pattern: ")
        if pattern == "" then
            print("Pattern cannot be empty")
            goto next_rule
        end

        local regex_type = vim.fn.input("Type (lua/vim) [vim]: ")
        if regex_type == "" then
            regex_type = "vim"
        end

        local pad = tonumber(vim.fn.input("Zero padding (0 = none): ")) or 0

        local ok, rule = pcall(Rule.new, {
            name = name,
            pattern = pattern,
            pad = pad,
            is_vim_regex = (regex_type == "vim"),
        })

        if not ok then
            print("Invalid rule: " .. rule)
            goto next_rule
        end

        table.insert(rules, rule)

        ::next_rule::
    end

    return rules
end

function M.run(opts)
    opts = opts or {}

    local bufnr = 0
    local first = opts.first or vim.fn.line("'<")
    local last = opts.last or vim.fn.line("'>")

    if first > last then
        print("Invalid range")
        return
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, first - 1, last, false)

    local new_lines = engine.apply(lines, opts.rules or {}, {
        step = opts.step,
    })

    vim.api.nvim_buf_set_lines(bufnr, first - 1, last, false, new_lines)
end

function M.prompt(opts)
    opts = opts or {}

    local rules = prompt_rules()
    if #rules == 0 then
        print("No rules defined. Aborting.")
        return
    end

    local step = tonumber(vim.fn.input("Step (+1 or -1): ")) or 1
    if step == 0 then
        step = 1
    end

    M.run({
        rules = rules,
        step = step,
        first = opts.first,
        last = opts.last,
    })
end

return M
