-- =========================
-- Mode: Visual
-- =========================

local map = require("keymaps.helpers").map_all

local mappings = {
    { "v", "J", ":move '>+1<CR>gv-gv", "Move selection down" },
    { "v", "K", ":move '<-2<CR>gv-gv", "Move selection up" },
    { "v", "<", "<gv", "Decrease indent" },
    { "v", ">", ">gv", "Increase indent" },
    { "v", "p", "\"_dP", "Paste without yanking" },
}

map(mappings)
