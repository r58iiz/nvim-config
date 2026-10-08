local map = require("keymaps.lib.map").map_all
local plugins = require("keymaps.lib.plugins")

map({
    { "n", "n", "nzz", "Center next search result" },
    { "n", "N", "Nzz", "Center prev search result" },
}, { remap = true })

if plugins.enabled("ggandor/leap.nvim") then
    map({
        { { "n", "x", "o" }, "s", "<Plug>(leap-forward)", "Leap forward" },
        { { "n", "x", "o" }, "S", "<Plug>(leap-backward)", "Leap backward" },
    }, { silent = true })
end
