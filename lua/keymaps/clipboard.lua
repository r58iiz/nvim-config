local lib = require("keymaps.lib.map")
local map = lib.map_all

local PREFIX = "<leader>y"
lib.group(PREFIX, "Yank")

local function yank(get)
    return function()
        vim.fn.setreg("+", get())
    end
end

map({
    {
        "n",
        PREFIX .. "a",
        yank(function()
            return vim.fn.expand("%:p")
        end),
        "Yank absolute file path",
    },
    {
        "n",
        PREFIX .. "f",
        yank(function()
            return vim.fn.expand("%:.")
        end),
        "Yank relative file path",
    },
    {
        "n",
        PREFIX .. "n",
        yank(function()
            return vim.fn.expand("%:t")
        end),
        "Yank file name",
    },
    {
        "n",
        PREFIX .. "p",
        yank(function()
            return vim.fn.expand("%:p:h")
        end),
        "Yank file directory",
    },
    {
        "n",
        PREFIX .. "d",
        yank(vim.fn.getcwd),
        "Yank working directory",
    },
    {
        "n",
        PREFIX .. "l",
        yank(function()
            return tostring(vim.fn.line("."))
        end),
        "Yank line number",
    },
    {
        "n",
        PREFIX .. "c",
        yank(function()
            return vim.fn.expand("%:.") .. ":" .. vim.fn.line(".")
        end),
        "Yank file and line",
    },
    {
        "n",
        PREFIX .. "u",
        yank(function()
            return vim.uri_from_bufnr(0)
        end),
        "Yank buffer URI",
    },
}, { silent = true })

map({
    { "v", "p", "\"_dP", "Paste without yanking" },
})
