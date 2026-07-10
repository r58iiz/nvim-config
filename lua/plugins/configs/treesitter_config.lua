local M = {}

function M.custom_setup()
    local status_ok, treesitter = pcall(require, "nvim-treesitter")
    if not status_ok then
        error("[Plugins][treesitter] Unable to load `treesitter`.")
        return
    end

    local install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "nvim-treesitter-parsers")

    treesitter.setup({
        install_dir = install_dir,
    })

    treesitter.install({
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
    })
end

return M
