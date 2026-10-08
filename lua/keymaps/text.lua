local lib = require("keymaps.lib.map")
local map = lib.map_all

local PREFIX = "<leader>c"
lib.group(PREFIX, "Custom")

local function action(name)
    return require("custom.actions." .. name)
end

map({
    {
        "n",
        PREFIX .. "sc",
        function()
            action("spellcheck").toggle()
        end,
        "Toggle spellcheck",
    },
    {
        "n",
        PREFIX .. "t",
        function()
            action("change_tabsize").prompt()
        end,
        "Change local tabsize",
    },

    {
        "n",
        PREFIX .. "f",
        function()
            action("format_markdown_table").format()
        end,
        "Format table under cursor",
    },
    {
        "v",
        PREFIX .. "f",
        function()
            action("format_markdown_table").format(vim.fn.line("v"), vim.fn.line("."))
        end,
        "Format table in selected lines",
    },

    {
        "n",
        PREFIX .. "r",
        function()
            action("renumber").form({ first = 1, last = vim.fn.line("$") })
        end,
        "Renumber (whole file)",
    },
    {
        "x",
        PREFIX .. "r",
        function()
            action("renumber").form()
        end,
        "Renumber (selection)",
    },
})
