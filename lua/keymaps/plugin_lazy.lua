-- =========================
-- Plugin: Lazy
-- =========================

local PREFIX = "<leader>L"

local map = require("keymaps.helpers").map_all

local mappings = {
    { "n", PREFIX .. "l", "<Cmd>Lazy<CR>", "Open Lazy" },
    { "n", PREFIX .. "p", "<Cmd>Lazy profile<CR>", "Show profile" },
    { "n", PREFIX .. "s", "<Cmd>Lazy sync<CR>", "Sync plugins" },
    { "n", PREFIX .. "u", "<Cmd>Lazy update<CR>", "Update plugins" },
    { "n", PREFIX .. "c", "<Cmd>Lazy clean<CR>", "Clean plugins" },
    {
        "n",
        PREFIX .. "m",
        function()
            require("plugin_loader").open_menu()
        end,
        "Plugin manager",
    },
}

map(mappings, { silent = true })
