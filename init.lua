local HOME = vim.env.HOME or vim.env.USERPROFILE
package.path = HOME .. "/.config/nvim/lua/?.lua;" .. package.path

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local config_files = {
    "options",
    "keymaps",
    "plugin_loader",
    "autocmds",
}

for _, file in pairs(config_files) do
    local success, res = pcall(require, file)
    if not success then
        vim.notify("[!] Failed to load " .. file .. " config. Error:\n" .. res, vim.log.levels.ERROR)
    end
    if type(res) ~= "boolean" and res["start"] then
        res["start"]()
    end
end
