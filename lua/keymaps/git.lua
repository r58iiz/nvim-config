local lib = require("keymaps.lib.map")
local map = lib.map_all
local plugins = require("keymaps.lib.plugins")
local fzf = require("keymaps.lib.fzf").call

local PREFIX = "<leader>g"
lib.group(PREFIX, "Git")

if plugins.enabled("ibhagwan/fzf-lua") then
    map({
        { "n", PREFIX .. "C", fzf("git_bcommits"), "Buffer git commits" },
        { "n", PREFIX .. "b", fzf("git_branches"), "Git branches" },
        { "n", PREFIX .. "c", fzf("git_commits"), "Git commits" },
        { "n", PREFIX .. "f", fzf("git_files"), "Git files" },
        { "n", PREFIX .. "l", fzf("git_blame"), "Git blame" },
        { "n", PREFIX .. "s", fzf("git_status"), "Git status" },
    }, { silent = true })
end

if plugins.enabled("NeogitOrg/neogit") then
    map({
        { "n", PREFIX .. "g", "<Cmd>Neogit<CR>", "Neogit" },
    }, { silent = true })
end
