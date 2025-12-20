local M = {}

function M.custom_setup()
    local status_ok, bufferline = pcall(require, "bufferline")
    if not status_ok then
        error("[Plugins][bufferline] Unable to load `bufferline`.")
        return
    end

    bufferline.setup({})
end

return M
