local function normalize_dir(dir)
    if not dir or dir == "" then
        return nil
    end
    -- remove trailing //
    return (dir:gsub("//+$", ""))
end

vim.api.nvim_create_user_command("NvimClearUndoBackup", function()
    local targets = {
        normalize_dir(vim.o.undodir),
        normalize_dir(vim.o.backupdir),
        normalize_dir(vim.o.directory),
    }

    local cleared = {}

    for _, dir in ipairs(targets) do
        if dir and vim.fn.isdirectory(dir) == 1 then
            vim.fn.delete(dir, "rf")
            vim.fn.mkdir(dir, "p")
            table.insert(cleared, dir)
        end
    end

    if #cleared > 0 then
        vim.notify("[Neovim] Cleared configured state dirs:\n" .. table.concat(cleared, "\n"), vim.log.levels.WARN)
    else
        vim.notify("[Neovim] No configured undo/backup directories found.", vim.log.levels.INFO)
    end
end, {
    desc = "Clear directories configured via undodir/backupdir(/directory)",
})

vim.api.nvim_create_user_command("Renumber", function(cmd)
    require("custom.renumber").command(cmd)
end, { range = true, nargs = "*", desc = "Renumber matches: /pattern/[l] [step] [pad]" })
