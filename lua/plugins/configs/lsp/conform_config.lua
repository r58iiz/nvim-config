local M = {}

function M.custom_setup()
    local status_ok, conform = pcall(require, "conform")
    if not status_ok then
        error("[Plugins][conform_config] Unable to load `conform`.")
        return
    end

    conform.setup({
        log_level = vim.log.levels.ERROR,
        notify_on_error = true,
        notify_no_formatters = true,
        formatters_by_ft = {
            c = { "clang_format" },
            cpp = { "clang_format" },
            javascript = { "biome-check" },
            json = { "biome-check" },
            lua = { "stylua" },
            python = { "autopep8", "black" },
            rust = { "rustfmt" },
            tex = { "latexindent" },
            toml = { "taplo" },
            typescript = { "biome-check" },
        },
        format_after_save = {
            lsp_fallback = true,
        },
        -- Customize formatters
        formatters = {
            clang_format = {
                append_args = function(self, ctx)
                    local local_shiftwidth = vim.bo.shiftwidth
                    local global_shiftwidth = vim.go.shiftwidth
                    if local_shiftwidth ~= global_shiftwidth then
                        return {
                            string.format(
                                "--style={IndentWidth: %d, TabWidth: %d}",
                                local_shiftwidth,
                                local_shiftwidth
                            ),
                        }
                    end
                    return {}
                end,
            },
            autopep8 = {
                -- append_args = { "--max-line-length=120" },
            },
            black = {
                -- append_args = { "--line-length=120" },
            },
            latexindent = {
                append_args = function(self, ctx)
                    local latexIndentConfigFile = vim.fs.joinpath(
                        vim.env.HOME or vim.env.USERPROFILE,
                        ".config",
                        "latexindent-config",
                        "mysettings.yaml"
                    )
                    local args = {
                        "-m",
                        "-g=no?log?file.log",
                    }

                    if vim.uv.fs_stat(latexIndentConfigFile) then
                        table.insert(args, "-l=" .. latexIndentConfigFile)
                    end

                    return args
                end,
            },
        },
    })
end

return M
