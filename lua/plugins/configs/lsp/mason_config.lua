local M = {}

function M.custom_setup()
    local status_ok, mason = pcall(require, "mason")
    if not status_ok then
        error("[Plugins][lsp-zero-config] Unable to load `mason`.")
        return
    end

    -- Mason Config
    local settings = {
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
        pip = {
            upgrade_pip = true,
            use_uv = true,
        },
        log_level = vim.log.levels.ERROR,
        max_concurrent_installers = 3,
    }
    mason.setup(settings)
end

return M
