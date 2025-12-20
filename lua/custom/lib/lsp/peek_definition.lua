local M = {}

local function close_peek(win, buf)
    if win and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
    end
    if buf and vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
    end
end

local function get_definition_client(bufnr)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if client.server_capabilities.definitionProvider then
            return client
        end
    end
end

function M.peek_definition(bufnr)
    bufnr = bufnr or 0

    local client = get_definition_client(bufnr)
    if not client then
        return false
    end

    local params = vim.lsp.util.make_position_params(bufnr, client.offset_encoding)

    vim.lsp.buf_request_all(bufnr, "textDocument/definition", params, function(results)
        for _, res in ipairs(vim.tbl_values(results)) do
            local result = res.result
            if result and not vim.tbl_isempty(result) then
                if vim.islist(result) then
                    result = result[1]
                end

                local uri = result.uri or result.targetUri
                local range = result.targetRange or result.range
                if not uri or not range then
                    return
                end

                local buf = vim.uri_to_bufnr(uri)
                vim.fn.bufload(buf)

                local cur_win = vim.api.nvim_get_current_win()
                local width = math.floor(vim.api.nvim_win_get_width(cur_win) * 0.8)
                local height = math.floor(vim.api.nvim_win_get_height(cur_win) * 0.8)

                local row = math.floor((vim.api.nvim_win_get_height(cur_win) - height) / 2)
                local col = math.floor((vim.api.nvim_win_get_width(cur_win) - width) / 2)

                local win = vim.api.nvim_open_win(buf, true, {
                    relative = "win",
                    win = cur_win,
                    border = "rounded",
                    width = width,
                    height = height,
                    row = row,
                    col = col,
                })

                vim.api.nvim_win_set_option(win, "winhighlight", "Normal:Normal,FloatBorder:Border")

                vim.api.nvim_win_set_cursor(win, {
                    range.start.line + 1,
                    range.start.character,
                })

                vim.bo[buf].bufhidden = "wipe"
                vim.wo[win].wrap = false
                vim.wo[win].scrolloff = 1
                vim.wo[win].statusline = ""
                vim.wo[win].winbar = ""

                vim.keymap.set("n", "q", function()
                    close_peek(win, buf)
                end, { buffer = buf, silent = true })

                return
            end
        end

        vim.notify("[peekDefinition] No definition found", vim.log.levels.INFO)
    end)

    return true
end

return M
