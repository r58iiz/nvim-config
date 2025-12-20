local Formatter = {}

local function map(tbl, f)
    local out = {}
    for i, v in ipairs(tbl) do
        out[i] = f(v, i)
    end
    return out
end

local function slice(tbl, first, last)
    local out = {}
    for i = first or 1, last or #tbl do
        out[#out + 1] = tbl[i]
    end
    return out
end

function Formatter.parse(table_string)
    local rows = {}

    for line in table_string:gmatch("[^\r\n]+") do
        if line:find("|") then
            local row = {}
            for cell in line:gmatch("[^|]+") do
                row[#row + 1] = vim.trim(cell)
            end
            rows[#rows + 1] = row
        end
    end

    return rows
end

function Formatter.trim_empty_columns(cells)
    while cells[1][1] == "" do
        for _, row in ipairs(cells) do
            table.remove(row, 1)
        end
    end

    while cells[1][#cells[1]] == "" do
        for _, row in ipairs(cells) do
            table.remove(row, #row)
        end
    end
end

function Formatter.column_widths(cells)
    local widths = {}

    for col = 1, #cells[1] do
        local max_width = 0
        for row = 1, #cells do
            if row ~= 2 then
                max_width = math.max(max_width, #(cells[row][col] or ""))
            end
        end
        widths[col] = max_width
    end

    return widths
end

function Formatter.normalize_cells(cells, widths)
    return map(cells, function(row, row_i)
        return map(row, function(cell, col_i)
            if row_i == 2 then
                return string.rep("-", widths[col_i])
            end
            return cell .. string.rep(" ", widths[col_i] - #cell)
        end)
    end)
end

function Formatter.render(cells)
    local header = "| " .. table.concat(cells[1], " | ") .. " |"
    local separator = "|-" .. table.concat(cells[2], "-|-") .. "-|"

    local body = slice(cells, 3)
    body = map(body, function(row)
        return "| " .. table.concat(row, " | ") .. " |"
    end)

    return table.concat({
        header,
        separator,
        table.concat(body, "\n"),
    }, "\n")
end

function Formatter.format(table_string)
    local cells = Formatter.parse(table_string)
    if #cells < 2 then
        return table_string
    end

    Formatter.trim_empty_columns(cells)
    local widths = Formatter.column_widths(cells)
    cells = Formatter.normalize_cells(cells, widths)

    return Formatter.render(cells)
end

return Formatter
