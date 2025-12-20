local M = {}

function M.custom_setup()
    local status_ok, barbar = pcall(require, "barbar")
    if not status_ok then
        error("[Plugins][barbar] Unable to load `barbar`.")
        return
    end

    barbar.setup({
        animation = false,
    })
end

return M
