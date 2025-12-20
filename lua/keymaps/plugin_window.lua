-- =========================
-- Plugin: Nvim-window
-- =========================

local map = require("keymaps.helpers").map_all

local mappings = {
    {
        "n",
        "<leader>e",
        function()
            require("nvim-window").pick()
        end,
        "Jump to window",
    },
}

map(mappings)
