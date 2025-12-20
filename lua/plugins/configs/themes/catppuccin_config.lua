local M = {}

function M.custom_setup()
    local status_ok, catppuccin = pcall(require, "catppuccin")
    if not status_ok then
        error("[Plugins][Themes][catppuccin] Unable to load `catppuccin`.")
        return
    end

    catppuccin.setup({
        flavour = "macchiato",
        background = {
            light = "mocha",
            dark = "macchiato",
        },
        transparent_background = true,
        show_end_of_buffer = true,
        term_colors = false,
        dim_inactive = {
            enabled = true,
            shade = "dark",
            percentage = 0.25,
        },
        no_italic = false,
        no_bold = false,
        styles = {
            comments = { "italic" },
            conditionals = { "italic" },
            loops = {},
            functions = { "bold", "undercurl" },
            keywords = { "underline" },
            strings = { "bold" },
            variables = {},
            numbers = {},
            booleans = {},
            properties = { "italic" },
            types = {},
            operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
            cmp = true,
            gitsigns = false,
            nvimtree = true,
            notify = false,
            mini = false,
            barbar = false,
            leap = true,
            mason = true,
            -- native_lsp = true,
            treesitter = true,
            which_key = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    })
end

return M
