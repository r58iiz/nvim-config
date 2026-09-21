-- =========================
-- Yank
-- =========================

local PREFIX = "<leader>y"

local map = require("keymaps.helpers").map_all

local mappings = {
    {
        "n",
        PREFIX .. "a",
        function()
            vim.fn.setreg("+", vim.fn.expand("%:p"))
        end,
        "Yank absolute file path",
    },
    {
        "n",
        PREFIX .. "c",
        function()
            local path = vim.fn.expand("%:.")
            local line = vim.fn.line(".")
            vim.fn.setreg("+", path .. ":" .. line)
        end,
        "Yank file and line",
    },
    {
        "n",
        PREFIX .. "d",
        function()
            vim.fn.setreg("+", vim.fn.getcwd())
        end,
        "Yank working directory",
    },
    {
        "n",
        PREFIX .. "f",
        function()
            vim.fn.setreg("+", vim.fn.expand("%:."))
        end,
        "Yank relative file path",
    },
    {
        "n",
        PREFIX .. "l",
        function()
            vim.fn.setreg("+", tostring(vim.fn.line(".")))
        end,
        "Yank line number",
    },
    {
        "n",
        PREFIX .. "n",
        function()
            vim.fn.setreg("+", vim.fn.expand("%:t"))
        end,
        "Yank file name",
    },
    {
        "n",
        PREFIX .. "p",
        function()
            vim.fn.setreg("+", vim.fn.expand("%:p:h"))
        end,
        "Yank file directory",
    },
    {
        "n",
        PREFIX .. "u",
        function()
            vim.fn.setreg("+", vim.uri_from_bufnr(0))
        end,
        "Yank buffer URI",
    },
}

map(mappings, { silent = true })
