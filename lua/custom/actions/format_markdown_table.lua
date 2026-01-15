local api = vim.api
local formatter = require("custom.lib.markdown.table_formatter")

local M = {}

local function getline(buf, n)
    return api.nvim_buf_get_lines(buf, n - 1, n, false)[1]
end

local function is_table_line(line)
    return line and line:find("|")
end

local function is_separator_line(line)
    return line and line:find("%-%|%-")
end

local function find_table_bounds(buf, cursor_line)
    local line_count = api.nvim_buf_line_count(buf)

    local start_line = cursor_line
    while start_line > 1 do
        if is_separator_line(getline(buf, start_line)) then
            start_line = start_line - 1
            break
        end
        start_line = start_line - 1
    end

    local end_line = cursor_line
    while end_line <= line_count do
        if not is_table_line(getline(buf, end_line)) then
            end_line = end_line - 1
            break
        end
        end_line = end_line + 1
    end

    if start_line >= end_line then
        return nil, nil
    end

    return start_line, end_line
end

function M.format(start_line, end_line)
    local buf = 0

    if not start_line or not end_line then
        local cursor = api.nvim_win_get_cursor(0)
        start_line, end_line = find_table_bounds(buf, cursor[1])

        if not start_line then
            vim.notify("No markdown table found", vim.log.levels.WARN)
            return
        end
    end

    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end

    local lines = api.nvim_buf_get_lines(buf, start_line - 1, end_line, false)

    local input = table.concat(lines, "\n")
    local output = formatter.format(input)

    api.nvim_buf_set_lines(buf, start_line - 1, end_line, false, vim.split(output, "\n"))
end

return M
