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
            require("custom.commands.change_tabsize").prompt()
        end,
        "Change local tabsize",
    },

    {
        "n",
        PREFIX .. "f",
        function()
            require("custom.commands.format_markdown_table").format()
        end,
        "Format table under cursor",
    },

    {
        "v",
        PREFIX .. "f",
        function()
            local start_line = vim.fn.line("v")
            local end_line = vim.fn.line(".")

            require("custom.commands.format_markdown_table").format(start_line, end_line)
        end,
        "Format table in selected lines",
    },

    {
        "n",
        PREFIX .. "r",
        function()
            require("custom.commands.renumber").prompt({
                first = 1,
                last = vim.fn.line("$"),
            })
        end,
        "Custom renumber",
    },

    {
        "x",
        PREFIX .. "r",
        function()
            require("custom.commands.renumber").prompt()
        end,
        "Custom renumber",
    },
}

map(mappings)
