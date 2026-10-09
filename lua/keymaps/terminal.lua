local map = require("keymaps.lib.map").map_all

map({
    { "t", "<ESC>", "<C-\\><C-n>", "Exit terminal mode" },
    { "t", "jk", "<C-\\><C-n>", "Exit terminal mode" },
    {
        "n",
        "<A-t>",
        function()
            require("custom.terminal").open_in_cwd()
        end,
        "Open terminal (cwd)",
    },
})
