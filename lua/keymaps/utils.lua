local M = {}

local plugin_loader = require("plugin_loader")
plugin_loader.load_persistent_config()
plugin_loader.populate_plugin_config()

function M.if_enabled(plugin, module)
    if plugin_loader.plugin_state[plugin] then
        require(module)
    end
end

return M
