local M = {}

function M.custom_setup()
    local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
        error("[Plugins][treesitter] Unable to load `treesitter`.")
        return
    end
    local status_ok, treesitter_install = pcall(require, "nvim-treesitter.install")
    if not status_ok then
        error("[Plugins][treesitter] Unable to load `treesitter.install`.")
        return
    end

    treesitter_install.compilers = { "cc" }

    treesitter_config.setup({
        -- A list of parser names, or "all"
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "html",
            "javascript",
            "lua",
            "markdown",
            "rust",
            "toml",
            "typescript",
            "vim",
            "vimdoc",
        },
        -- Incremental selection
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "g<Space>",
                node_incremental = "g<Space>",
                scope_incremental = false,
                node_decremental = "g<bs>",
            },
        },

        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,

        auto_install = false,

        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        rainbow = {
            enable = true,
        },
    })
end

return M
