return {
    ["marko-cerovac/material.nvim"] = {
        -- [Theme] material
        -- https://github.com/marko-cerovac/material.nvim
        lazy = true,
        config = function()
            require("plugins.configs.themes.material_config").custom_setup()
            vim.g.material_style = "deep ocean"
            vim.cmd("colorscheme material")
        end,
    },

    ["EdenEast/nightfox.nvim"] = {
        -- [Theme] nightfox
        -- https://github.com/EdenEast/nightfox.nvim
        lazy = true,
        config = function()
            vim.cmd("colorscheme duskfox")
            -- colorscheme nightfox
            -- colorscheme dayfox
            -- colorscheme dawnfox
            -- colorscheme duskfox
            -- colorscheme nordfox
            -- colorscheme terafox
            -- colorscheme carbonfox
        end,
    },

    ["sainnhe/everforest"] = {
        -- [Theme] everforest
        -- https://github.com/sainnhe/everforest
        lazy = true,
        config = function()
            vim.cmd("colorscheme everforest")
        end,
    },

    ["olimorris/onedarkpro.nvim"] = {
        -- [Theme] onedarkpro
        -- https://github.com/olimorris/onedarkpro.nvim
        lazy = true,
        config = function()
            vim.cmd("colorscheme onedark_vivid")
        end,
    },

    ["navarasu/onedark.nvim"] = {
        -- [Theme] onedark.nvim
        -- https://github.com/navarasu/onedark.nvim
        lazy = true,
        config = function()
            require("onedark").setup({
                style = "warm",
                -- dark, darker, cool, deep, warm, warmer, light
            })
        end,
    },

    ["AstroNvim/astrotheme"] = {
        -- [Theme] Astrotheme
        -- https://github.com/AstroNvim/astrotheme
        lazy = true,
        config = function()
            require("plugins.configs.themes.astrotheme_config").custom_setup()
            vim.cmd("colorscheme astrodark")
        end,
    },

    ["morhetz/gruvbox"] = {
        -- [Theme] Gruvbox
        -- https://github.com/morhetz/gruvbox
        lazy = true,
        config = function()
            vim.cmd("let g:gruvbox_italic=1")
            vim.cmd("colorscheme gruvbox")
        end,
    },

    ["nyoom-engineering/oxocarbon.nvim"] = {
        -- [Theme] oxocarbon
        -- https://github.com/nyoom-engineering/oxocarbon.nvim
        lazy = true,
        config = function()
            vim.opt.background = "dark"
            vim.cmd("colorscheme oxocarbon")
            -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        end,
    },

    ["bluz71/vim-moonfly-colors"] = {
        -- [Theme] vim-moonfly
        -- https://github.com/bluz71/vim-moonfly-colors
        name = "moonfly",
        lazy = true,
        config = function()
            vim.cmd("colorscheme moonfly")
        end,
    },

    ["slugbyte/lackluster.nvim"] = {
        -- [Theme] lackluster
        -- https://github.com/slugbyte/lackluster.nvim
        lazy = true,
        config = function()
            vim.cmd("colorscheme lackluster-mint")
        end,
    },

    ["rose-pine/neovim"] = {
        -- [Theme] Rose pine
        -- https://github.com/rose-pine/neovim
        name = "rose-pine",
        lazy = true,
        config = function()
            require("plugins.configs.themes.rosepine_config").custom_setup()
            vim.cmd("colorscheme rose-pine-moon")
        end,
    },

    ["catppuccin/nvim"] = {
        -- [Theme] material
        -- https://github.com/catppuccin/nvim
        name = "catppuccin",
        lazy = true,
        config = function()
            require("plugins.configs.themes.catppuccin_config").custom_setup()
            vim.cmd("colorscheme catppuccin")
        end,
    },

    ["folke/tokyonight.nvim"] = {
        -- [Theme] Tokyonight
        -- https://github.com/folke/tokyonight.nvim
        lazy = true,
        config = function()
    -- colorscheme tokyonight-night
    -- colorscheme tokyonight-storm
    -- colorscheme tokyonight-moon
    vim.cmd("colorscheme tokyonight-night")
        end,
    },

    ["rebelot/kanagawa.nvim"] = {
        -- [Theme] Kanagawa
        -- https://github.com/rebelot/kanagawa.nvim
        lazy = true,
        config = function()
            vim.cmd("colorscheme kanagawa-wave")
        end,
    },

    ["HoNamDuong/hybrid.nvim"] = {
        -- [Theme]
        -- https://github.com/HoNamDuong/hybrid.nvim
        lazy = true,
        config = function()
            vim.cmd("colorscheme hybrid")
        end,
    },

    ["metalelf0/black-metal-theme-neovim"] = {
        -- [Theme] Black Metal Theme Neovim
        -- https://github.com/metalelf0/black-metal-theme-neovim
        lazy = true,
        config = function()
            vim.cmd("colorscheme burzum")
        end,
    },

    ["webhooked/kanso.nvim"] = {
        -- [Theme] Kanso
        -- https://github.com/webhooked/kanso.nvim
        lazy = true,
        config = function()
            require("kanso").setup({
                dimInactive = true,
                background = {
                    dark = "ink", -- ink|zen|mist
                },
                foreground = "saturated", -- default|saturated
            })

            vim.cmd("colorscheme kanso")
        end,
    },
}
