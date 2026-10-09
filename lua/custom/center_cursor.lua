local M = {}

local AUGROUP_PREFIX = "CenterCursorBuf"
local STATE_VAR = "center_cursor_state"

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

--- Toggle keeping the cursor line centered in the given buffer.
---@param opts? { bufnr?: integer, mode?: "normal"|"insert"|"both" }
---@return boolean enabled
function M.toggle(opts)
    opts = opts or {}
    local bufnr = opts.bufnr or 0
    bufnr = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
    local mode = opts.mode or "insert"

    local group = AUGROUP_PREFIX .. bufnr
    local state = vim.b[bufnr][STATE_VAR] or {}

    if state.enabled then
        pcall(vim.api.nvim_del_augroup_by_name, group)
        vim.b[bufnr][STATE_VAR] = nil
        vim.notify("Center cursor (buffer): disabled", vim.log.levels.INFO)
        return false
    end

    vim.b[bufnr][STATE_VAR] = { enabled = true, mode = mode }

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

    vim.notify("Center cursor (buffer): enabled", vim.log.levels.INFO)
    return true
end

return M
