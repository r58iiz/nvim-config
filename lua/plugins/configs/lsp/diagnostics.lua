local M = {}

function M.custom_setup()
    local config = {
        signs = { -- false
            text = {
                [vim.diagnostic.severity.ERROR] = "✘",
                [vim.diagnostic.severity.WARN] = "", -- "▲",
                [vim.diagnostic.severity.INFO] = "", -- "»",
                [vim.diagnostic.severity.HINT] = "", -- "⚑",
            },
        },
        virtual_text = true,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
            suffix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.o.winborder = "rounded"
end

return M
