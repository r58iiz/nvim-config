-- =========================
-- Mode: Terminal
-- =========================

-- function()
--     local curr_file_dir = vim.fn.expand("%:p:h")
--     local curr_file_dir_short = vim.fn.expand("%:h")
--
--     local orig_window = vim.api.nvim_get_current_win()
--     local term_buffer = vim.api.nvim_create_buf(true, false)
--     local term_window = vim.api.nvim_open_win(term_buffer, false, {
--         split = "below",
--         win = 0,
--         height = 5,
--     })
--
--     vim.api.nvim_set_current_win(term_window)
--     vim.fn.termopen(
--         "powershell.exe" .. " -NoLogo -NoExit -Command " .. "'cd \"" .. curr_file_dir .. "\";'",
--         {
--             on_exit = function(_, exit_code)
--                 vim.notify(
--                     "[B " .. term_buffer .. "] Terminal exited with code: " .. exit_code,
--                     vim.log.levels.WARN,
--                     { normal_notify = true }
--                 )
--             end,
--         }
--     )
--     vim.api.nvim_buf_set_name(term_buffer, "[PS] " .. curr_file_dir_short)
--     vim.api.nvim_set_current_win(orig_window)
-- end,

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
        "<C-t>",
        function()
            local cwd = vim.fn.expand("%:p:h")
            if cwd == "" then
                cwd = vim.loop.cwd()
            end

            vim.cmd("belowright split")
            local win = vim.api.nvim_get_current_win()
            vim.api.nvim_win_set_height(win, 10)

            vim.fn.termopen("powershell.exe -NoLogo -NoExit -Command cd '" .. cwd .. "'")

            vim.cmd("startinsert")
        end,
        "Open terminal (cwd)",
    },
}

map(mappings)
