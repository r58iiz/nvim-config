local M = {}

local function make_set(list)
    local set = {}
    for _, v in ipairs(list) do
        set[v] = true
    end
    return set
end

function M.disable_on_filetypes(filetypes)
    if type(filetypes) ~= "table" then
        return true
    end

    local disabled = make_set(filetypes)
    return not disabled[vim.bo.filetype]
end

M.is = function(ft)
    return vim.bo.filetype == ft
end

M.is_any = function(fts)
    if type(fts) ~= "table" then
        return false
    end

    local current = vim.bo.filetype
    for _, ft in ipairs(fts) do
        if ft == current then
            return true
        end
    end
    return false
end

M.is_not_any = function(fts)
    return not M.is_any(fts)
end

return M
