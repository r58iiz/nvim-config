-- =========================
-- Custom
-- =========================

local PREFIX = "<leader>c"

local map = require("keymaps.helpers").map_all

local mappings = {
    {
        "n",
        PREFIX .. "sc",
        function()
            local spell = vim.opt_local.spell:get()
            vim.opt_local.spell = not spell

            if not spell then
                vim.opt_local.spelllang = { "en_us", "en_gb" }
                vim.notify("Spellcheck enabled", vim.log.levels.INFO)
            else
                vim.notify("Spellcheck disabled", vim.log.levels.INFO)
            end
        end,
        "Toggle spellcheck",
    },

    {
        "n",
        PREFIX .. "t",
        function()
            require("custom.actions.change_tabsize").prompt()
        end,
        "Change local tabsize",
    },

    {
        "n",
        PREFIX .. "f",
        function()
            require("custom.actions.format_markdown_table").format()
        end,
        "Format table under cursor",
    },

    {
        "v",
        PREFIX .. "f",
        function()
            local start_line = vim.fn.line("v")
            local end_line = vim.fn.line(".")

            require("custom.actions.format_markdown_table").format(start_line, end_line)
        end,
        "Format table in selected lines",
    },

    {
        "n",
        PREFIX .. "r",
        function()
            require("custom.actions.renumber").form({
                first = 1,
                last = vim.fn.line("$"),
            })
        end,
        "Renumber (whole file)",
    },

    {
        "x",
        PREFIX .. "r",
        function()
            require("custom.actions.renumber").form()
        end,
        "Renumber (selection)",
    },

    {
        "n",
        PREFIX .. "zz",
        function()
            require("custom.actions.center_cursor").toggle({ mode = "both" })
        end,
        "Toggle center cursor (Both)",
    },

    {
        "n",
        PREFIX .. "zi",
        function()
            require("custom.actions.center_cursor").toggle({ mode = "insert" })
        end,
        "Toggle center cursor (Ins)",
    },

    {
        "n",
        PREFIX .. "zn",
        function()
            require("custom.actions.center_cursor").toggle({ mode = "normal" })
        end,
        "Toggle center cursor (Norm)",
    },

    {
        "n",
        PREFIX .. "lw",
        function()
            require("custom.actions.listchars").toggle("whitespace")
        end,
        "Toggle whitespace chars",
    },

    {
        "n",
        PREFIX .. "lt",
        function()
            require("custom.actions.listchars").toggle("tab")
        end,
        "Toggle tab chars",
    },

    {
        "n",
        PREFIX .. "le",
        function()
            require("custom.actions.listchars").toggle("eol_lead")
        end,
        "Toggle EOL/lead chars",
    },

    {
        "n",
        PREFIX .. "la",
        function()
            require("custom.actions.listchars").disable_all()
        end,
        "Disable all listchars",
    },
}

map(mappings)
