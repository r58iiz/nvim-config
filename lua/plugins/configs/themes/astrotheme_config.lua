local M = {}

function M.custom_setup()
    local status_ok, astrotheme = pcall(require, "astrotheme")
    if not status_ok then
        error("[Plugins][Themes][astrotheme] Unable to load `astrotheme`.")
        return
    end

    astrotheme.setup({
        palette = "astrodark",
        background = {
            light = "astrolight",
            dark = "astrodark",
        },

        style = {
            transparent = false,
            inactive = true,
            float = true,
            neotree = true,
            border = true,
            title_invert = false,
            italic_comments = true,
            simple_syntax_colors = false,
        },

        termguicolors = true,

        terminal_color = true,

        plugin_default = "auto",
    })
end

return M
