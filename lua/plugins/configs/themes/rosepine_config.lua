local M = {}

function M.custom_setup()
    local status_ok, rosepine = pcall(require, "rose-pine")
    if not status_ok then
        error("[Plugins][Themes][rose-pine] Unable to load `rose-pine`.")
        return
    end
    rosepine.setup({
        variant = "main",
        dark_variant = "main",
        dim_inactive_windows = true,
        extend_background_behind_borders = true,

        enable = {
            terminal = true,
            legacy_highlights = true,
            migrations = true,
        },

        styles = {
            bold = true,
            italic = true,
            transparency = true,
        },
    })
end

return M
