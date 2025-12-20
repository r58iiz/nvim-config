local M = {}

function M.custom_setup()
    local status_ok, twilight = pcall(require, "twilight")
    if not status_ok then
        error("[Plugins][twilight] Unable to load `twilight`.")
        return
    end
    twilight.setup({
        dimming = {
            alpha = 0.6,

            color = { "Normal", "#ffffff" },
            term_bg = "#000000",
            inactive = true,
        },
        context = 5,
        treesitter = true,

        expand = {
            "method",
            "function",
        },
        exclude = {},
    })
end

return M
