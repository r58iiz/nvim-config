local map = require("keymaps.helpers").map_all

-- =========================
-- Core editor mappings
-- =========================

local core_mappings = {
    { { "n", "v" }, "<leader>q", "<Cmd>q!<CR>", "Quit" },
    { "n", "<leader>w", "<Cmd>w<CR>", "Write" },
    { "n", "<ESC>", "<Cmd>nohlsearch<CR>", "Clear search highlight" },
    {
        "n",
        "<leader>?",
        function()
            require("which-key").show({ global = false })
        end,
        "Buffer local keymaps",
    },
}

map(core_mappings)

-- =========================
-- Window navigation
-- =========================

local window_navigation = {
    { "n", "<C-h>", "<C-w>h", "Switch to left window" },
    { "n", "<C-j>", "<C-w>j", "Switch to lower window" },
    { "n", "<C-k>", "<C-w>k", "Switch to upper window" },
    { "n", "<C-l>", "<C-w>l", "Switch to right window" },
}
map(window_navigation)

-- =========================
-- Window resizing
-- =========================

local window_resizing = {
    { "n", "<S-Left>", "<Cmd>vertical resize +1<CR>", "Resize window left" },
    { "n", "<S-Right>", "<Cmd>vertical resize -1<CR>", "Resize window right" },
    { "n", "<S-Up>", "<Cmd>resize -1<CR>", "Resize window up" },
    { "n", "<S-Down>", "<Cmd>resize +1<CR>", "Resize window down" },
}
map(window_resizing)

-- =========================
-- Misc
-- =========================

local misc = {
    { "n", "n", "nzz", "Center next search result" },
    { "n", "N", "Nzz", "Center prev search result" },
}
map(misc, { remap = true })
