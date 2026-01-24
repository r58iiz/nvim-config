local M = {}

function M.custom_setup()
    local status_ok, lsp_zero = pcall(require, "lsp-zero")
    if not status_ok then
        error("[Plugins][lsp-zero-config] Unable to load `lsp-zero`.")
        return
    end

    local status_ok, mason = pcall(require, "mason")
    if not status_ok then
        error("[Plugins][lsp-zero-config] Unable to load `mason`.")
        return
    end

    local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not status_ok then
        error("[Plugins][lsp-zero-config] Unable to load `mason-lspconfig`.")
        return
    end

    local status_ok, lsp_diagnostics = pcall(require, "plugins.configs.lsp.diagnostics")
    if not status_ok then
        error("[Plugins][lsp-zero-config] Unable to load `lsp_diagnostics`.")
        return
    end

    local status_ok, cmp_config = pcall(require, "plugins.configs.lsp.cmp_config")
    if not status_ok then
        error("[Plugins][lsp-zero-config] Unable to load `cmp`.  ")
        return
    end

    -- Cmp
    cmp_config.custom_setup()

    -- Diagnostics
    lsp_diagnostics.custom_setup()

    -- LSP Zero
    local lsp = lsp_zero.preset({})

    lsp.on_attach(function(client, bufnr)
        if client.name == "rust_analyzer" then
            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end
        end
        if client.name == "pylsp" then
            client.server_capabilities.renameProvider = false
        end

        require("keymaps.lsp").attach(bufnr)
    end)

    lsp_zero.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "»",
    })

    lsp.setup()
    lsp.extend_lspconfig()

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

    -- Mason LSP Config
    mason_lspconfig.setup({
        automatic_enable = true,
    })
end

return M
