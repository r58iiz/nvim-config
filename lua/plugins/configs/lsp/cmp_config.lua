local cmp = require("cmp")
local cmp_format = require("lsp-zero").cmp_format()
local luasnip = require("luasnip")

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
}

local M = {}

-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/autocomplete.md

function M.custom_setup()
    cmp.setup({

        view = {
            entries = "custom",
        },

        -- disable completion in comments
        enabled = function()
            local context = require("cmp.config.context")
            if vim.api.nvim_get_mode().mode == "c" then
                return true
            else
                return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
            end
        end,

        -- Setup snippets
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },

        mapping = {

            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<C-p>"] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = "insert" })
                end
            end),
            ["<C-n>"] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = "insert" })
                end
            end),

            ["<C-c>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
        },

        formatting = {
            fields = { "abbr", "kind", "menu" },
            format = function(entry, vim_item)
                -- NOTE: order matters
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snip]",
                    -- vsnip = "[Snip]",
                    -- buffer = "[Buffer]",
                    -- path = "[Path]",
                })[entry.source.name]
                return vim_item
            end,
        },

        sources = {
            {
                name = "nvim_lsp",
            },
            {
                name = "luasnip",
            },
            {
                name = "nvim_lua",
            },
            {
                name = "nvim_lsp_signature_help",
            },
            {
                name = "buffer",
            },
        },

        experimental = {
            ghost_text = true,
        },

        matching = {
            disallow_fuzzy_matching = true,
            disallow_fullfuzzy_matching = true,
            disallow_partial_fuzzy_matching = true,
            disallow_partial_matching = false,
            disallow_prefix_unmatching = true,
        },
    })

    -- Visual Studio Code Dark+ Theme Colors in the Menu
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
    vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
    vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
    vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
    vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
    vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
    vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
    vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
    vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
end

return M
