local map = require("keymaps.lib.map").map_all

map({
    { { "n", "v" }, "<leader>q", "<Cmd>q!<CR>", "Quit" },
    { "n", "<leader>w", "<Cmd>w<CR>", "Write" },
    { "n", "<ESC>", "<Cmd>nohlsearch<CR>", "Clear search highlight" },
    { "i", "jk", "<ESC>", "Exit insert" },
    {
        "n",
        "<leader>?",
        function()
            require("which-key").show({ global = false })
        end,
        "Buffer local keymaps",
    },
})
