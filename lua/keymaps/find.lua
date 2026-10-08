local plugins = require("keymaps.lib.plugins")
if not plugins.enabled("ibhagwan/fzf-lua") then
    return
end

local lib = require("keymaps.lib.map")
local map = lib.map_all
local fzf = require("keymaps.lib.fzf").call

local PREFIX = "<leader>f"
lib.group(PREFIX, "Find")

map({
    { "n", PREFIX .. "f", fzf("files"), "Find files" },
    { "n", PREFIX .. "r", fzf("oldfiles"), "Recent files" },
    { "n", PREFIX .. "w", fzf("grep_cword"), "Grep word under cursor" },
    { "n", PREFIX .. "F", fzf("builtin"), "Fzflua Builtins" },
    {
        "n",
        PREFIX .. "g",
        fzf(function()
            local actions = require("fzf-lua.actions")
            require("fzf-lua").live_grep({
                actions = {
                    ["ctrl-q"] = actions.file_sel_to_loclist,
                    ["ctrl-Q"] = actions.file_sel_to_qf,
                },
            })
        end),
        "Live grep",
    },
    {
        "n",
        PREFIX .. "c",
        fzf("files", function()
            return { cwd = vim.fn.expand("%:p:h") }
        end),
        "Find files near current file",
    },
}, { silent = true })
