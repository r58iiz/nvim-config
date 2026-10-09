local M = {}

function M.open_in_cwd()
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
end

return M
