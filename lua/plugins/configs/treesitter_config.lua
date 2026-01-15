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
        parser_install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "nvim-treesitter-parsers"),
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "haskell",
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
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "g<Space>",
                node_incremental = "g<Space>",
                scope_incremental = false,
                node_decremental = "g<bs>",
            },
        },
        auto_install = true,
        sync_install = false,
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

    vim.opt.runtimepath:append(vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "nvim-treesitter-parsers"))
end

return M
