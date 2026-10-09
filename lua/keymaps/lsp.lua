local M = {}

local lib = require("keymaps.lib.map")
local map = lib.map_all
local fzf = require("keymaps.lib.fzf").call

local PREFIX = ";"
lib.group(PREFIX, "LSP")
lib.group(PREFIX .. "T", "LSP symbols")

local lsp = vim.lsp.buf
local diag = vim.diagnostic

local mappings = {
    { "n", "K", lsp.hover, "LSP hover" },
    { "n", PREFIX .. "r", lsp.rename, "Rename" },
    { "n", PREFIX .. "s", lsp.signature_help, "Signature help" },
    {
        "n",
        PREFIX .. "p",
        function()
            require("custom.peek_definition").open()
        end,
        "Peek definition",
    },
    { "n", PREFIX .. "f", fzf("lsp_code_actions"), "Code action (fzf)" },
    {
        "x",
        PREFIX .. "f",
        function()
            local s, e = vim.fn.getpos("v"), vim.fn.getpos(".")
            vim.lsp.buf.format({
                async = true,
                range = { start = { s[2] - 1, s[3] - 1 }, ["end"] = { e[2] - 1, e[3] - 1 } },
            })
        end,
        "Format selection",
    },

    { "n", PREFIX .. "[", diag.goto_prev, "Prev diagnostic" },
    { "n", PREFIX .. "]", diag.goto_next, "Next diagnostic" },
    { "n", PREFIX .. "o", diag.open_float, "Open diagnostics" },
    { "n", PREFIX .. "q", diag.setloclist, "Diagnostics to loclist" },
    { "n", PREFIX .. "b", fzf("diagnostics_document"), "Buffer diagnostics (fzf)" },
    { "n", PREFIX .. "e", fzf("diagnostics_workspace"), "Workspace diagnostics (fzf)" },

    { "n", PREFIX .. "d", fzf("lsp_definitions"), "Definitions (fzf)" },
    { "n", PREFIX .. "D", fzf("lsp_declarations"), "Declarations (fzf)" },
    { "n", PREFIX .. "R", fzf("lsp_references"), "References (fzf)" },
    { "n", PREFIX .. "i", fzf("lsp_implementations"), "Implementations (fzf)" },
    { "n", PREFIX .. "t", fzf("lsp_typedefs"), "Type definitions (fzf)" },

    { "n", PREFIX .. "Td", fzf("lsp_document_symbols"), "Document symbols (fzf)" },
    { "n", PREFIX .. "Tw", fzf("lsp_workspace_symbols"), "Workspace symbols (fzf)" },
    { "n", PREFIX .. "TW", fzf("lsp_live_workspace_symbols"), "Live workspace symbols (fzf)" },
    { "n", PREFIX .. "Tf", fzf("lsp_finder"), "LSP finder (fzf)" },
    { "n", PREFIX .. "Ti", fzf("lsp_incoming_calls"), "Incoming calls (fzf)" },
    { "n", PREFIX .. "To", fzf("lsp_outgoing_calls"), "Outgoing calls (fzf)" },
}

function M.attach(bufnr)
    map(mappings, { buffer = bufnr, silent = true })
end

return M
