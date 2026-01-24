local center_cursor = require("custom.lib.ui.center_cursor")

local M = {}

function M.toggle(opts)
    opts = opts or {}
    local bufnr = opts.bufnr or 0
    local mode = opts.mode or "insert"

    local enabled = center_cursor.toggle(bufnr, { mode = mode })

    if enabled then
        vim.notify("Center cursor (buffer): enabled", vim.log.levels.INFO)
    else
        vim.notify("Center cursor (buffer): disabled", vim.log.levels.INFO)
    end
end

return M
