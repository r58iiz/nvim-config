local M = {}

---@param tabsize integer
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

function M.prompt()
    local input = vim.fn.input("Tabsize: ")

    if input == "" then
        M.reset()
        vim.notify(("Reset buffer indent to defaults (tabstop=%d)"):format(vim.bo.tabstop), vim.log.levels.INFO)
        return
    end

    local tabsize = tonumber(input)
    if tabsize and tabsize > 0 then
        M.set(tabsize)
        vim.notify(("Set buffer indent to %d spaces"):format(tabsize), vim.log.levels.INFO)
        return
    end

    vim.notify("Invalid tab size: " .. input, vim.log.levels.ERROR)
end

return M
