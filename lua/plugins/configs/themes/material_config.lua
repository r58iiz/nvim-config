local M = {}

function M.custom_setup()
    local status_ok, material = pcall(require, "material")
    if not status_ok then
        error("[Plugins][Themes][material] Unable to load `material`.")
        return
    end

    material.setup({
        contrast = {
            terminal = false,
            sidebars = true,
            floating_windows = true,
            cursor_line = false,
            non_current_windows = true,
            filetypes = {},
        },

        styles = {
            comments = {
                italic = true,
            },
            strings = {
                bold = true,
            },
            keywords = {
                underline = true,
            },
            functions = {
                bold = true,
                undercurl = true,
            },
            variables = {},
            operators = {},
            types = {},
        },

        plugins = {
            "nvim-cmp",
            "nvim-web-devicons",
            "which-key",
            "gitsigns",
            -- "dap",
            -- "dashboard",
            -- "hop",
            -- "indent-blankline",
            -- "lspsaga",
            -- "mini",
            -- "neogit",
            -- "sneak",
            -- "nvim-navic",
            -- "trouble",
        },

        disable = {
            colored_cursor = false,
            borders = false,
            background = false,
            term_colors = false,
            eob_lines = true,
        },

        high_visibility = {
            lighter = false,
            darker = true,
        },

        lualine_style = "stealth",

        async_loading = true,

        custom_colors = nil,

        custom_highlights = {},
    })
end

return M
