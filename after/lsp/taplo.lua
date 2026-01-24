-- vim.lsp.config("taplo", {})
return {
    filetypes = { "toml" },
    root_dir = vim.fs.root(0, function(name, path)
        return name:match("%.toml$") ~= nil
    end),
}
