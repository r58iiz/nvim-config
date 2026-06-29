vim.api.nvim_create_user_command("Renumber", function(cmd)
    require("custom.actions.renumber").command(cmd)
end, { range = true, nargs = "*" })
