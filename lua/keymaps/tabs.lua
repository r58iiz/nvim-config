-- =========================
-- Tabs
-- =========================

local PREFIX = "<leader>t"

local map = require("keymaps.helpers").map_all

local mappings = {
    { "n", PREFIX .. "n", "<Cmd>tabnew<CR>", "New tab" },
    { "n", PREFIX .. "c", "<Cmd>tabclose<CR>", "Close tab" },

    { "n", PREFIX .. "b", "<Cmd>tab split<CR>", "Open buffer in new tab" },

    { "n", PREFIX .. "]", "gt", "Next tab" },
    { "n", PREFIX .. "[", "gT", "Previous tab" },

    { "n", PREFIX .. "1", "1gt", "Tab 1" },
    { "n", PREFIX .. "2", "2gt", "Tab 2" },
    { "n", PREFIX .. "3", "3gt", "Tab 3" },
    { "n", PREFIX .. "4", "4gt", "Tab 4" },

    { "n", PREFIX .. ",", "<Cmd>tabmove -1<CR>", "Move tab left" },
    { "n", PREFIX .. ".", "<Cmd>tabmove +1<CR>", "Move tab right" },
}

map(mappings)
