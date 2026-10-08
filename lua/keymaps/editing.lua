local map = require("keymaps.lib.map").map_all

map({
    { "v", "J", ":move '>+1<CR>gv-gv", "Move selection down" },
    { "v", "K", ":move '<-2<CR>gv-gv", "Move selection up" },
    { "i", "<A-j>", "<Esc>:m .+1<CR>==gi", "Move line down" },
    { "i", "<A-k>", "<Esc>:m .-2<CR>==gi", "Move line up" },
    { "v", "<", "<gv", "Decrease indent" },
    { "v", ">", ">gv", "Increase indent" },
})
