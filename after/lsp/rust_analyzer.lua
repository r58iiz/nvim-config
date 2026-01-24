-- vim.lsp.config("rust_analyzer", {})
return {
    cmd = { "rust-analyzer" },
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                enable = false,
            },
        },
    },
}
