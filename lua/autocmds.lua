-- =========================
-- Cursorline behavior
-- =========================

-- Only show cursorline in the current window and in normal mode.
local cursorline_group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "InsertLeave" }, {
    group = cursorline_group,
    callback = function()
        vim.wo.cursorline = true
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "InsertEnter" }, {
    group = cursorline_group,
    callback = function()
        vim.wo.cursorline = false
    end,
})

-- =========================
-- Relative number toggle
-- =========================

local number_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    group = number_group,
    callback = function()
        if vim.wo.number then
            vim.wo.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    group = number_group,
    callback = function()
        if vim.wo.number then
            vim.wo.relativenumber = false
        end
    end,
})

-- =========================
-- Terminal behavior
-- =========================

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

-- =========================
-- Treesitter
-- =========================

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        if vim.bo.buftype == "" then
            local status_ok, err = pcall(vim.treesitter.start)
            if status_ok then
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo.foldmethod = "expr"
            end
        end
    end,
})
