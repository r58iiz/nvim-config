-- =========================
-- Git (fzf-lua)
-- =========================

local PREFIX = "<leader>g"

local map = require("keymaps.helpers").map_all
local fzf = require("keymaps.module_fzf").call

local mappings = {
    { "n", PREFIX .. "C", fzf("git_bcommits"), "Buffer git commits" },
    { "n", PREFIX .. "b", fzf("git_branches"), "Git branches" },
    { "n", PREFIX .. "c", fzf("git_commits"), "Git commits" },
    { "n", PREFIX .. "f", fzf("git_files"), "Git files" },
    { "n", PREFIX .. "l", fzf("git_blame"), "Git blame" },
    { "n", PREFIX .. "s", fzf("git_status"), "Git status" },
}

map(mappings, { silent = true })
