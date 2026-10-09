local lib = require("keymaps.lib.map")
local map = lib.map_all

local PREFIX = "<leader>c"
lib.group(PREFIX, "Custom")

local function feature(name)
    return require("custom." .. name)
end

map({
    {
        "n",
        PREFIX .. "S",
        function()
            feature("spellcheck").toggle()
        end,
        "Toggle spellcheck",
    },
    {
        "n",
        PREFIX .. "t",
        function()
            feature("tabsize").prompt()
        end,
        "Change local tabsize",
    },

    {
        "n",
        PREFIX .. "f",
        function()
            feature("markdown_table").format()
        end,
        "Format table under cursor",
    },
    {
        "v",
        PREFIX .. "f",
        function()
            feature("markdown_table").format(vim.fn.line("v"), vim.fn.line("."))
        end,
        "Format table in selected lines",
    },

    {
        "n",
        PREFIX .. "r",
        function()
            feature("renumber").form({ first = 1, last = vim.fn.line("$") })
        end,
        "Renumber (whole file)",
    },
    {
        "x",
        PREFIX .. "r",
        function()
            feature("renumber").form()
        end,
        "Renumber (selection)",
    },
})
