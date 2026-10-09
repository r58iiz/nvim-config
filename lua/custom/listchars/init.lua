local chars = require("custom.listchars.chars")

local M = {}

local enabled = {
    whitespace = false,
    tab = false,
    eol_lead = false,
}

local function apply()
    local active = chars.compute(enabled)
    vim.opt.list = next(active) ~= nil
    vim.opt.listchars = active
end

---@param group "whitespace"|"tab"|"eol_lead"
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

return M
