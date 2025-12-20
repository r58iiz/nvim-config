local M = {}

function M.map_all(mappings, base_opts)
    base_opts = base_opts or {}

    for _, m in ipairs(mappings) do
        local mode, lhs, rhs, desc = unpack(m)
        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", base_opts, { desc = desc }))
    end
end

return M
