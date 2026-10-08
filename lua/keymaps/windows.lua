local map = require("keymaps.lib.map").map_all
local plugins = require("keymaps.lib.plugins")

local dirs = { h = "left", j = "lower", k = "upper", l = "right" }
local focus = {}
for key, name in pairs(dirs) do
    local desc = "Switch to " .. name .. " window"
    focus[#focus + 1] = { "n", "<C-" .. key .. ">", "<C-w>" .. key, desc }
    focus[#focus + 1] = { "t", "<C-" .. key .. ">", "<C-\\><C-n><C-w>" .. key, desc }
end
map(focus)

map({
    { "n", "<S-Left>", "<Cmd>vertical resize +1<CR>", "Resize window left" },
    { "n", "<S-Right>", "<Cmd>vertical resize -1<CR>", "Resize window right" },
    { "n", "<S-Up>", "<Cmd>resize -1<CR>", "Resize window up" },
    { "n", "<S-Down>", "<Cmd>resize +1<CR>", "Resize window down" },
})

if plugins.enabled("yorickpeterse/nvim-window") then
    map({
        {
            "n",
            "<leader>e",
            function()
                require("nvim-window").pick()
            end,
            "Jump to window",
        },
    })
end
