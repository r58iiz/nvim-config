local M = {}

---@param mappings table[] list of { mode, lhs, rhs, desc }
---@param base_opts? table  options applied to every mapping (silent, buffer, remap...)
function M.map_all(mappings, base_opts)
    base_opts = base_opts or {}

    for _, m in ipairs(mappings) do
        local mode, lhs, rhs, desc = unpack(m)
        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", base_opts, { desc = desc }))
    end
end

local groups = {}

---@param lhs string
---@param name string
---@param mode? string|string[]
function M.group(lhs, name, mode)
    groups[#groups + 1] = { lhs, group = name, mode = mode or "n" }
end

function M.flush_groups()
    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.add(groups)
    end
end

return M
