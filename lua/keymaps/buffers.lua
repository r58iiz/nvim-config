-- =========================
-- Buffer management
-- =========================

local PREFIX = "<leader>b"

local map = require("keymaps.helpers").map_all
local fzf = require("keymaps.module_fzf").call

local mappings = {
    { "n", PREFIX .. "[", "<Cmd>bprevious<CR>", "Previous buffer" },
    { "n", PREFIX .. "]", "<Cmd>bnext<CR>", "Next buffer" },

    { "n", PREFIX .. "l", fzf("buffers"), "List buffers" },

    { "n", PREFIX .. "n", "<Cmd>enew<CR>", "New buffer" },
    { "n", PREFIX .. "h", "<Cmd>new<CR>", "New buffer (horizontal split)" },
    { "n", PREFIX .. "v", "<Cmd>vnew<CR>", "New buffer <vertical split" },

    { "n", PREFIX .. "d", "<Cmd>bdelete<CR>", "Delete buffer" },

    {
        "n",
        PREFIX .. "D",
        function()
            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(bufnr) then
                    vim.api.nvim_buf_delete(bufnr, { force = true })
                end
            end
        end,
        "Delete all buffers",
    },

    {
        "n",
        PREFIX .. "x",
        function()
            local win = vim.api.nvim_get_current_win()
            local buf = vim.api.nvim_get_current_buf()

            local new_buf = vim.api.nvim_create_buf(true, false)
            vim.api.nvim_win_set_buf(win, new_buf)

            vim.api.nvim_buf_delete(buf, { force = false })
        end,
        "Close buffer, replace with blank buffer",
    },
}

map(mappings, { silent = true })
