local HOME = vim.env.HOME or vim.env.USERPROFILE
package.path = vim.fs.joinpath(HOME, ".config/nvim/lua/?.lua") .. ";" .. package.path

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local config_files = {
    { name = "options" },
    { name = "autocmds" },
    {
        name = "plugin_loader",
        startup = function(mod)
            mod["setup"]({
                config_path = vim.fs.joinpath(vim.env.HOME, ".config", "nvim", "plugin_state.json"),
            })
            mod["start"]()
        end,
    },
    { name = "keymaps" },
}

for _, entry in ipairs(config_files) do
    local ok, mod = pcall(require, entry.name)

    if not ok then
        vim.notify("[!] Failed to load " .. entry.name .. ". Error:\n" .. mod, vim.log.levels.ERROR)
        goto continue
    end

    if type(entry.startup) == "function" then
        entry.startup(mod)
    elseif type(mod) == "table" and type(mod.setup) == "function" then
        mod.setup(entry.opts)
    elseif type(mod) == "table" and type(mod.start) == "function" then
        mod.start()
    end

    ::continue::
end
