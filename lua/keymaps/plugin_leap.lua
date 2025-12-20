-- =========================
-- Plugin: Leap
-- =========================

local map = require("keymaps.helpers").map_all

local mappings = {
    { { "n", "x", "o" }, "s", "<Plug>(leap-forward)", "Leap forward" },
    { { "n", "x", "o" }, "S", "<Plug>(leap-backward)", "Leap backward" },
}

map(mappings, { silent = true })
