-- =========================
-- File navigation (fzf-lua)
-- =========================

local PREFIX = "<leader>f"

local map = require("keymaps.helpers").map_all
local fzf = require("keymaps.module_fzf").call

local mappings = {
    { "n", PREFIX .. "f", fzf("files"), "Find files" },
    { "n", PREFIX .. "r", fzf("oldfiles"), "Recent files" },

    { "n", PREFIX .. "w", fzf("grep_cword"), "Grep word under cursor" },
    { "n", PREFIX .. "F", fzf("builtin"), "Fzflua Builtins" },

    {
        "n",
        PREFIX .. "g",
        fzf(function()
            require("fzf-lua").live_grep({
                actions = {
                    ["ctrl-q"] = require("fzf-lua.actions").file_sel_to_loclist,
                    ["ctrl-Q"] = require("fzf-lua.actions").file_sel_to_qf,
                },
            })
        end),
        "Live grep",
    },

    {
        "n",
        PREFIX .. "c",
        fzf("files", {
            cwd = vim.fn.expand("%:p:h"),
        }),
        "Find files near current file",
    },
}

map(mappings, { silent = true })
