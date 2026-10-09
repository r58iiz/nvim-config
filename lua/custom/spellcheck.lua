local M = {}

function M.toggle()
    local was_on = vim.opt_local.spell:get()
    vim.opt_local.spell = not was_on

    if not was_on then
        vim.opt_local.spelllang = { "en_us", "en_gb" }
        vim.notify("Spellcheck enabled", vim.log.levels.INFO)
    else
        vim.notify("Spellcheck disabled", vim.log.levels.INFO)
    end
end

return M
