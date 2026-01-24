local M = {}

function M.custom_setup()
    local status_ok, treesitter = pcall(require, "nvim-treesitter")
    if not status_ok then
        error("[Plugins][treesitter] Unable to load `treesitter`.")
        return
    end

    treesitter.setup({
        install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "nvim-treesitter-parsers"),
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

    vim.opt.runtimepath:append(vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "nvim-treesitter-parsers"))
end

return M
