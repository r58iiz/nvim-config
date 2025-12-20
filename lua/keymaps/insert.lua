-- =========================
-- Mode: Insert
-- =========================

local map = require("keymaps.helpers").map_all

local mappings = {
    { "i", "jk", "<ESC>", "Exit insert" },
    { "i", "<A-j>", "<Esc>:m .+1<CR>==gi", "Move line down" },
    { "i", "<A-k>", "<Esc>:m .-2<CR>==gi", "Move line up" },
}

map(mappings)
