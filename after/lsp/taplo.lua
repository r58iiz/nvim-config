-- vim.lsp.config("taplo", {})
return {
    filetypes = { "toml" },
    root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, function(name)
            return name:match("%.toml$") ~= nil
        end) or vim.fs.root(bufnr, ".git") or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))

        on_dir(root)
    end,
}
