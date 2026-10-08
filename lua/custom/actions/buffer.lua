local M = {}

function M.delete_all()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
            vim.api.nvim_buf_delete(bufnr, { force = true })
        end
    end
end

function M.close_keep_window()
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_get_current_buf()

    local new_buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_win_set_buf(win, new_buf)

    vim.api.nvim_buf_delete(buf, { force = false })
end

return M
