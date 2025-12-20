-- =========================
-- Plugin: Zen / Twilight
-- =========================

local PREFIX = "<leader>z"

local map = require("keymaps.helpers").map_all

local mappings = {
    { "n", PREFIX .. "z", "<Cmd>ZenMode<CR>", "Zen mode" },
    { "n", PREFIX .. "t", "<Cmd>Twilight<CR>", "Twilight" },
}

map(mappings)
