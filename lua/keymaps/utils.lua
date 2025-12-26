local M = {}

local plugin_loader = require("plugin_loader")

function M.if_enabled(option_id, module)
    if plugin_loader.is_enabled("plugins", option_id) then
        require(module)
        return true
    end
    return false
end

return M
