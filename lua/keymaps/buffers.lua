local lib = require("keymaps.lib.map")
local map = lib.map_all
local fzf = require("keymaps.lib.fzf").call
local buf = require("custom.actions.buffer")

local PREFIX = "<leader>b"
lib.group(PREFIX, "Buffers")

map({
    { "n", PREFIX .. "[", "<Cmd>bprevious<CR>", "Previous buffer" },
    { "n", PREFIX .. "]", "<Cmd>bnext<CR>", "Next buffer" },
    { "n", PREFIX .. "l", fzf("buffers"), "List buffers" },

    { "n", PREFIX .. "n", "<Cmd>enew<CR>", "New buffer" },
    { "n", PREFIX .. "h", "<Cmd>new<CR>", "New buffer (horizontal split)" },
    { "n", PREFIX .. "v", "<Cmd>vnew<CR>", "New buffer (vertical split)" },

    { "n", PREFIX .. "d", "<Cmd>bdelete<CR>", "Delete buffer" },
    { "n", PREFIX .. "D", buf.delete_all, "Delete all buffers" },
    { "n", PREFIX .. "x", buf.close_keep_window, "Close buffer, replace with blank buffer" },
}, { silent = true })
