local listchars = require("custom.lib.ui.listchars")

local M = {}

local enabled = {
    whitespace = true,
    tab_eol = true,
    lead = false,
}

local function apply()
    local chars = listchars.compute(enabled)
    vim.opt.list = next(chars) ~= nil
    vim.opt.listchars = chars
end

function M.toggle(group)
    if enabled[group] == nil then
        vim.notify("Listchars: unknown group — " .. tostring(group), vim.log.levels.ERROR)
        return
    end
    enabled[group] = not enabled[group]
    apply()
end

function M.disable_all()
    for group in pairs(enabled) do
        enabled[group] = false
    end
    apply()
end

function M.setup()
    apply()
end

return M
