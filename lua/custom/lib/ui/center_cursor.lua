local M = {}

local augroup_prefix = "CenterCursorBuf"

local function macro_active()
    return vim.fn.reg_recording() ~= "" or vim.fn.reg_executing() ~= ""
end

local function events_from_mode(mode)
    if mode == "normal" then
        return { "CursorMoved" }
    elseif mode == "both" then
        return { "CursorMoved", "CursorMovedI" }
    elseif mode == "insert" then
        return { "CursorMovedI" }
    end
end

function M.toggle(bufnr, opts)
    bufnr = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
    opts = opts or {}

    local mode = opts.mode or "insert"
    local var = "center_cursor_state"
    local group = augroup_prefix .. bufnr

    local state = vim.b[bufnr][var] or {}
    local enabled = not state.enabled

    if not enabled then
        pcall(vim.api.nvim_del_augroup_by_name, group)
        vim.b[bufnr][var] = nil
        return false
    end

    vim.b[bufnr][var] = {
        enabled = true,
        mode = mode,
    }

    vim.api.nvim_create_autocmd(events_from_mode(mode), {
        group = vim.api.nvim_create_augroup(group, { clear = true }),
        buffer = bufnr,
        callback = function()
            if macro_active() then
                return
            end

            local win = vim.api.nvim_get_current_win()
            local cursor = vim.api.nvim_win_get_cursor(win)

            vim.cmd("normal! zz")

            vim.api.nvim_win_set_cursor(win, cursor)
        end,
    })

    return true
end

return M
