-- =========================
-- Plugin: Outline
-- =========================

local map = require("keymaps.helpers").map_all

local mappings = {
    { "n", ";O", "<Cmd>Outline<CR>", "Toggle outline" },
}

map(mappings)
