local Formatter = {}

local function split_plain(str, sep)
    local out = {}
    local sep_len = #sep
    local start = 1
    while true do
        local i = str:find(sep, start, true)
        if not i then
            out[#out + 1] = str:sub(start)
            break
        end
        out[#out + 1] = str:sub(start, i - 1)
        start = i + sep_len
    end
    return out
end

local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

local function import_table(table_string)
    local rows_raw = split_plain(table_string, "\n")

    while #rows_raw > 0 and not rows_raw[1]:find("|", 1, true) do
        table.remove(rows_raw, 1)
    end

    local cells = {}

    for row_i, raw_line in ipairs(rows_raw) do
        if not raw_line:find("|", 1, true) then
            -- skip
        else
            local row = {}
            local cols = split_plain(raw_line, "|")
            for _, cell in ipairs(cols) do
                local c = trim(cell)
                if row_i == 2 then
                    c = c:match("^%-+$") and "-" or c
                end
                row[#row + 1] = c
            end
            cells[#cells + 1] = row
        end
    end

    return cells
end

local function get_column_widths(cells)
    local widths = {}
    for _, row in ipairs(cells) do
        for col_i, cell in ipairs(row) do
            local w = #cell
            if not widths[col_i] or widths[col_i] < w then
                widths[col_i] = w
            end
        end
    end
    return widths
end

local function strip_empty_edge_columns(cells)
    local widths = get_column_widths(cells)

    if widths[1] == 0 then
        for _, row in ipairs(cells) do
            table.remove(row, 1)
        end
        widths = get_column_widths(cells)
    end

    local last = #widths
    if last > 0 and widths[last] == 0 then
        for _, row in ipairs(cells) do
            if #row == last then
                table.remove(row, last)
            end
        end
    end
end

local function add_missing_cells(cells, num_cols)
    for _, row in ipairs(cells) do
        for col_i = #row + 1, num_cols do
            row[col_i] = ""
        end
    end
end

local function pad_cells(cells, widths)
    for row_i, row in ipairs(cells) do
        for col_i, cell in ipairs(row) do
            local target = widths[col_i] or 0
            local pad_char = (row_i == 2) and "-" or " "
            while #row[col_i] < target do
                row[col_i] = row[col_i] .. pad_char
            end
            _ = cell -- suppress unused
        end
    end
end

local function render(cells)
    local lines = {}

    lines[#lines + 1] = "| " .. table.concat(cells[1], " | ") .. " |"

    lines[#lines + 1] = "|-" .. table.concat(cells[2], "-|-") .. "-|"

    for row_i = 3, #cells do
        lines[#lines + 1] = "| " .. table.concat(cells[row_i], " | ") .. " |"
    end

    return table.concat(lines, "\n")
end

function Formatter.format(table_string)
    local cells = import_table(table_string)

    if #cells < 2 then
        return table_string
    end

    strip_empty_edge_columns(cells)

    local widths = get_column_widths(cells)
    local num_cols = #widths

    add_missing_cells(cells, num_cols)
    pad_cells(cells, widths)

    return render(cells)
end

return Formatter
