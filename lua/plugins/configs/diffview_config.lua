local M = {}

function M.custom_setup()
    local status_ok, diffview = pcall(require, "diffview")
    if not status_ok then
        error("[Plugins][diffview] Unable to load `diffview`.")
        return
    end

    diffview.setup({
        hooks = {
            diff_buf_win_enter = function()
                -- Turn off line wrapping and list chars and relative numbers
                vim.opt_local.wrap = false
                vim.opt_local.list = false
                vim.opt_local.relativenumber = false
            end,
        },
    })
end

return M
