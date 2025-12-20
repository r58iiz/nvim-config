return {
    ["yorickpeterse/nvim-window"] = {
        -- [Window Hopper] nvim-window
        -- https://github.com/yorickpeterse/nvim-window
        lazy = true,
    },

    ["lukas-reineke/indent-blankline.nvim"] = {
        -- [LSP/Productivity] indent-blankline
        -- https://github.com/lukas-reineke/indent-blankline.nvim
        lazy = true,
        event = { "InsertEnter" },
        main = "ibl",
        config = function()
            require("plugins.configs.indentblankline_config").custom_setup()
        end,
    },

    ["hedyhli/outline.nvim"] = {
        -- [LSP/Productivity] outline.nvim
        -- https://github.com/hedyhli/outline.nvim
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        opts = {},
    },

    ["stevearc/oil.nvim"] = {
        -- [File Browser] oilnvim
        -- https://github.com/stevearc/oil.nvim
        lazy = false,
        dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
        config = function()
            require("plugins.configs.oil_config").custom_setup()
        end,
    },

    ["stevearc/quicker.nvim"] = {
        -- [QoL] quicker
        -- https://github.com/stevearc/quicker.nvim
        "stevearc/quicker.nvim",
        event = "FileType qf",
        config = function()
            require("quicker").setup()
        end,
    },

    ["stevearc/conform.nvim"] = {
        -- [Formatting] Conform
        -- https://github.com/stevearc/conform.nvim
        lazy = true,
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        cond = require("custom.lib.buffer.filetype").disable_on_filetypes({ "text" }),
        config = function()
            require("plugins.configs.lsp.conform_config").custom_setup()
        end,
    },

    ["nvim-treesitter/nvim-treesitter"] = {
        -- [Highlighting] Treesitter
        -- https://github.com/nvim-treesitter/nvim-treesitter
        lazy = true,
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        cond = require("custom.lib.buffer.filetype").disable_on_filetypes({ "text" }),
        config = function()
            require("plugins.configs.treesitter_config").custom_setup()
        end,
    },

    ["nvim-treesitter/nvim-treesitter-textobjects"] = {
        -- [Treesitter Addon] Treesitter-textobjects
        -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        lazy = true,
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    lsp_interop = {
                        enable = true,
                        border = "none",
                        floating_preview_opts = {},
                        peek_definition_code = {
                            [";pd"] = "@function.outer",
                            [";pD"] = "@class.outer",
                        },
                    },
                },
            })
        end,
    },

    ["m4xshen/hardtime.nvim"] = {
        -- [QOL] hardtime.nvim
        -- https://github.com/m4xshen/hardtime.nvim
        lazy = false,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {},
    },

    ["ibhagwan/fzf-lua"] = {
        -- [Prompts/Search] fzf-lua
        -- https://github.com/ibhagwan/fzf-lua
        lazy = true,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("fzf-lua").register_ui_select()
        end,
    },

    ["nvim-lualine/lualine.nvim"] = {
        -- [Statusline] Lualine
        -- https://github.com/nvim-lualine/lualine.nvim
        dependencies = { "kyazdani42/nvim-web-devicons" },
        event = "VimEnter",
        lazy = true,
        config = function()
            require("plugins.configs.lualine_config").custom_setup()
        end,
    },

    ["folke/zen-mode.nvim"] = {
        -- [Productivity] Zen mode
        -- https://github.com/folke/zen-mode.nvim
        cmd = { "ZenMode" },
        lazy = true,
        config = function()
            require("plugins.configs.zenmode_config").custom_setup()
        end,
    },

    ["lervag/vimtex"] = {
        -- [Latex] Vimtex
        -- https://github.com/lervag/vimtex
        ft = "tex",
        lazy = true,
        config = function()
            require("plugins.configs.vimtex_config").custom_setup()
        end,
    },

    ["numToStr/Comment.nvim"] = {
        -- [LSP/Productivity] Comment.nvim
        -- https://github.com/numToStr/Comment.nvim
        lazy = false,
        cond = require("custom.lib.buffer.filetype").disable_on_filetypes({ "text" }),
        config = function()
            require("plugins.configs.comment_config").custom_setup()
        end,
    },

    ["folke/twilight.nvim"] = {
        -- [Productivity] Twilight
        -- https://github.com/folke/twilight.nvim
        cmd = "Twilight",
        lazy = true,
        config = function()
            require("plugins.configs.twilight_config").custom_setup()
        end,
    },

    ["folke/which-key.nvim"] = {
        -- [Keybinds] WhichKey
        -- https://github.com/folke/which-key.nvim
        event = "VimEnter",
        cond = true,
        opts = require("plugins.configs.whichkey_config").return_config(),
        config = function()
            vim.o.timeoutlen = 500
            vim.o.timeout = true
            require("plugins.configs.whichkey_config").custom_setup()
        end,
    },

    ["ggandor/leap.nvim"] = {
        -- [Jumping] Leap
        -- https://github.com/ggandor/leap.nvim
        event = "BufReadPost",
        lazy = true,
    },

    ["rcarriga/nvim-notify"] = {
        -- [Notifs] nvim-notify
        -- https://github.com/rcarriga/nvim-notify
        config = function()
            local orig_notify = vim.notify
            local new_notify = require("notify")

            local normal_notify = { "nvim-tree.lua" }

            vim.notify = function(msg, level, opts)
                local info = debug.getinfo(2, "S") or {}
                local source = string.replace((info.source or ""), "@", "")
                local found = false

                if opts and opts["normal_notify"] ~= nil and opts["normal_notify"] then
                    found = true
                else
                    for _, item in ipairs(normal_notify) do
                        if string.find(source, item, 1, true) then
                            found = true
                            break
                        end
                    end
                end

                if found then
                    orig_notify(msg, level, opts)
                else
                    new_notify(msg, level, opts)
                end
            end
        end,
    },

    ["sindrets/diffview.nvim"] = {
        -- [Git] diffview.nvim
        -- https://github.com/sindrets/diffview.nvim
        lazy = true,
        cmd = { "DiffviewFileHistory", "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        config = function()
            require("plugins.configs.diffview_config").custom_setup()
        end,
    },

    ["NeogitOrg/neogit"] = {
        -- [Git] neogit
        -- https://github.com/NeogitOrg/neogit
        lazy = true,
        cmd = { "Neogit" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "ibhagwan/fzf-lua",
        },
    },

    ["lewis6991/gitsigns.nvim"] = {
        -- [Git] Gitsigns
        -- https://github.com/lewis6991/gitsigns.nvim
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.configs.gitsigns_config").custom_setup()
        end,
    },

    ["VonHeikemen/lsp-zero.nvim"] = {
        -- [LSP] LSP Zero
        -- https://github.com/VonHeikemen/lsp-zero.nvim
        branch = "v3.x",
        event = { "BufReadPre", "BufNewFile" },
        lazy = true,
        cond = require("custom.lib.buffer.filetype").disable_on_filetypes({ "text" }),
        config = function()
            require("plugins.configs.lsp.lsp_zero_config").custom_setup()
        end,
        dependencies = {
            {
                -- [LSP] Mason.nvim
                -- https://github.com/williamboman/mason.nvim
                "KingMichaelPark/mason.nvim", -- "williamboman/mason.nvim"
                commit = "b0827eb6cee026d0ed2fabab081296705a92240e",
                lazy = true,
            },
            {
                -- [LSP] Mason-lspconfig.nvim
                -- https://github.com/williamboman/mason-lspconfig.nvim
                "williamboman/mason-lspconfig.nvim",
                lazy = true,
            },
            {
                -- [LSP] Builtin
                -- https://github.com/neovim/nvim-lspconfig
                "neovim/nvim-lspconfig",
                lazy = true,
            },
            {
                -- [LSP] Nvim-Cmp
                -- https://github.com/hrsh7th/nvim-cmp
                "hrsh7th/nvim-cmp",
                lazy = true,
                dependencies = {
                    { "hrsh7th/cmp-buffer" },
                    { "hrsh7th/cmp-nvim-lsp" },
                    { "hrsh7th/cmp-path" },
                    { "hrsh7th/cmp-nvim-lsp-signature-help" },
                    { "saadparwaiz1/cmp_luasnip" },
                    { "L3MON4D3/LuaSnip" },
                },
            },
        },
    },

    ["kevinhwang91/nvim-ufo"] = {
        -- [Folding] nvim UFO
        -- https://github.com/kevinhwang91/nvim-ufo
        lazy = true,
        cond = require("custom.lib.buffer.filetype").disable_on_filetypes({ "text" }),
        keys = {
            {
                "zR",
                function()
                    require("ufo").openAllFolds()
                end,
            },
            {
                "zM",
                function()
                    require("ufo").closeAllFolds()
                end,
            },
        },
        dependencies = {
            {
                "kevinhwang91/promise-async",
            },
        },
    },

    ["romgrk/barbar.nvim"] = {
        -- [Tabline] barbar.nvim
        -- https://github.com/romgrk/barbar.nvim
        event = "VimEnter",
        lazy = true,
        config = function()
            require("plugins.configs.barbar_config").custom_setup()
        end,
    },

    ["akinsho/bufferline.nvim"] = {
        -- [Tabline] bufferline.nvim
        -- https://github.com/akinsho/bufferline.nvim
        event = "VimEnter",
        lazy = true,
        config = function()
            require("plugins.configs.bufferline_config").custom_setup()
        end,
    },

    ["folke/flash.nvim"] = {
        -- [Jumping] Flash.nvim
        -- https://github.com/folke/flash.nvim
        event = "VeryLazy",
        opts = {
            modes = {
                search = {
                    enabled = true,
                },
            },
        },
        keys = require("plugins.configs.flash_keys_config"),
    },

    ["RRethy/vim-illuminate"] = {
        -- [LSP] vim-illuminate
        -- https://github.com/RRethy/vim-illuminate
        event = "BufRead",
        cond = require("custom.lib.buffer.filetype").disable_on_filetypes({ "text" }),
        config = function()
            require("plugins.configs.illuminate_config").custom_setup()
        end,
    },
}
