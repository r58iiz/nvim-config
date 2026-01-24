-- vim.lsp.config("eslint", {})
return {
    workingDirectory = { mode = "auto" },
    settings = {
        completions = {
            completeFunctionCalls = true,
        },
    },
}
