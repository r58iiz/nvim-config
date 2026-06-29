local api = vim.api
local formatter = require("custom.lib.markdown.table_formatter")

local M = {}

local function getline(buf, n)
    return api.nvim_buf_get_lines(buf, n - 1, n, false)[1]
end

local function is_table_line(line)
    return line ~= nil and line:find("|", 1, true) ~= nil
end

local function find_table_bounds(buf, cursor_line)
    local line_count = api.nvim_buf_line_count(buf)

    if not is_table_line(getline(buf, cursor_line)) then
        return nil, nil
    end

    local start_line = cursor_line
    while start_line > 1 and is_table_line(getline(buf, start_line - 1)) do
        start_line = start_line - 1
    end

    local end_line = cursor_line
    while end_line < line_count and is_table_line(getline(buf, end_line + 1)) do
        end_line = end_line + 1
    end

    return start_line, end_line
end

function M.format(start_line, end_line)
    local buf = 0

    if not start_line or not end_line then
        local cursor = api.nvim_win_get_cursor(0)
        start_line, end_line = find_table_bounds(buf, cursor[1])

        if not start_line then
            vim.notify("Cursor is not inside a markdown table", vim.log.levels.WARN)
            return
        end
    else
        if start_line > end_line then
            start_line, end_line = end_line, start_line
        end
    end

    local lines = api.nvim_buf_get_lines(buf, start_line - 1, end_line, false)
    local input = table.concat(lines, "\n")
    local output = formatter.format(input)

    api.nvim_buf_set_lines(buf, start_line - 1, end_line, false, vim.split(output, "\n", { plain = true }))
end

return M
