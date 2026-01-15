local buffer_tabsize = require("custom.lib.buffer.tabsize")

local M = {}

function M.prompt(opts)
    opts = opts or {}

    local input = vim.fn.input("Tabsize: ")

    if input == "" then
        buffer_tabsize.reset()
        vim.notify(("Reset buffer indent to defaults (tabstop=%d)"):format(vim.bo.tabstop), vim.log.levels.INFO)
        return
    end

    local tabsize = tonumber(input)
    if tabsize > 0 then
        buffer_tabsize.set(tabsize)
        vim.notify(("Set buffer indent to %d spaces"):format(tabsize), vim.log.levels.INFO)
        return
    end

    vim.notify("Invalid tab size: " .. input, vim.log.levels.ERROR)
end

return M
