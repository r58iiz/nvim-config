-- =========================
-- LSP
-- =========================

local M = {}

local PREFIX = ";"

local map = require("keymaps.helpers").map_all
local fzf = require("keymaps.module_fzf").call

local lsp = vim.lsp.buf
local diag = vim.diagnostic

local mappings = {
    { "n", "K", lsp.hover, "LSP hover" },
    { "n", PREFIX .. "r", lsp.rename, "Rename" },
    { "n", PREFIX .. "s", lsp.signature_help, "Signature help" },

    { "n", PREFIX .. "[", diag.goto_prev, "Prev diagnostic" },
    { "n", PREFIX .. "]", diag.goto_next, "Next diagnostic" },
    { "n", PREFIX .. "o", diag.open_float, "Open diagnostics" },
    { "n", PREFIX .. "q", diag.setloclist, "Diagnostics to loclist" },

    { "n", PREFIX .. "D", fzf("lsp_declarations"), "Declarations (fzf)" }, -- lsp.declaration
    { "n", PREFIX .. "R", fzf("lsp_references"), "References (fzf)" }, -- lsp.references
    { "n", PREFIX .. "b", fzf("diagnostics_document"), "Buffer diagnostics (fzf)" },
    { "n", PREFIX .. "d", fzf("lsp_definitions"), "Definitions (fzf)" }, -- lsp.definition
    { "n", PREFIX .. "e", fzf("diagnostics_workspace"), "Workspace diagnostics (fzf)" },
    { "n", PREFIX .. "f", fzf("lsp_code_actions"), "Code action (fzf)" }, -- lsp.code_action
    { "n", PREFIX .. "i", fzf("lsp_implementations"), "Implementations (fzf)" }, -- lsp.implementation
    { "n", PREFIX .. "t", fzf("lsp_typedefs"), "Type definitions (fzf)" }, -- lsp.type_definition

    { "n", PREFIX .. "TW", fzf("lsp_live_workspace_symbols"), "Live workspace symbols (fzf)" },
    { "n", PREFIX .. "Td", fzf("lsp_document_symbols"), "Document symbols (fzf)" },
    { "n", PREFIX .. "Tf", fzf("lsp_finder"), "LSP finder (fzf)" },
    { "n", PREFIX .. "Ti", fzf("lsp_incoming_calls"), "Incoming calls (fzf)" },
    { "n", PREFIX .. "To", fzf("lsp_outgoing_calls"), "Outgoing calls (fzf)" },
    { "n", PREFIX .. "Tw", fzf("lsp_workspace_symbols"), "Workspace symbols (fzf)" },

    {
        "n",
        PREFIX .. "p",
        function()
            require("custom.actions.peek_definition").peek_definition()
        end,
        "Peek definition",
    },

    {
        "x",
        PREFIX .. "f",
        function()
            local start_pos = vim.fn.getpos("v")
            local end_pos = vim.fn.getpos(".")

            vim.lsp.buf.format({
                async = true,
                range = {
                    ["start"] = { start_pos[2] - 1, start_pos[3] - 1 },
                    ["end"] = { end_pos[2] - 1, end_pos[3] - 1 },
                },
            })
        end,
        "Format selection",
    },
}

function M.attach(bufnr)
    map(mappings, { buffer = bufnr, silent = true })
end

return M
