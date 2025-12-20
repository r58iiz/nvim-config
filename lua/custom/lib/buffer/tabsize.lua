local M = {}

function M.set(tabsize)
    vim.bo.tabstop = tabsize
    vim.bo.shiftwidth = tabsize
    vim.bo.softtabstop = tabsize
end

function M.reset()
    vim.bo.tabstop = vim.go.tabstop
    vim.bo.shiftwidth = vim.go.shiftwidth
    vim.bo.softtabstop = vim.go.softtabstop
end

return M
