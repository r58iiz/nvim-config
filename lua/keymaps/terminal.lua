-- =========================
-- Mode: Terminal
-- =========================

local map = require("keymaps.helpers").map_all

local mappings = {
    { "t", "<ESC>", "<C-\\><C-n>", "Exit terminal mode" },

    { "t", "jk", "<C-\\><C-n>", "Exit terminal mode" },

    { "t", "<C-h>", "<C-\\><C-n><C-w>h", "Switch to left window" },
    { "t", "<C-j>", "<C-\\><C-n><C-w>j", "Switch to lower window" },
    { "t", "<C-k>", "<C-\\><C-n><C-w>k", "Switch to upper window" },
    { "t", "<C-l>", "<C-\\><C-n><C-w>l", "Switch to right window" },

    {
        "n",
        "<A-t>",
        function()
            local cwd = vim.fn.expand("%:p:h")
            local cwd_short = vim.fn.expand("%:h")
            if cwd == "" then
                cwd = vim.loop.cwd()
                cwd_short = vim.fs.basename(cwd)
            end

            vim.cmd("belowright split")
            local win = vim.api.nvim_get_current_win()
            vim.api.nvim_win_set_height(win, 10)

            local buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_win_set_buf(win, buf)

            vim.fn.termopen("powershell.exe -NoLogo -NoExit -Command cd '" .. cwd .. "'", {
                on_exit = function(_, exit_code)
                    vim.notify("[B " .. buf .. "] Terminal exited with code: " .. exit_code, vim.log.levels.WARN)
                end,
            })

            vim.api.nvim_buf_set_name(buf, "[PS] " .. cwd_short)
            vim.cmd("startinsert")
        end,
        "Open terminal (cwd)",
    },
}

map(mappings)
