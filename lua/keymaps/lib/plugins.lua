local M = {}

---@param id string plugin id as used in plugins/init.lua, e.g. "ibhagwan/fzf-lua"
function M.enabled(id)
    return require("plugin_loader").is_enabled("plugins", id)
end

return M
