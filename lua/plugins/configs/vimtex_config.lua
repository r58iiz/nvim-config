local M = {}

function M.custom_setup()
    vim.g.vimtex_view_general_viewer = "SumatraPDF"
    vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
    vim.g.vimtex_mappings_prefix = "<localleader>v"
    vim.g.vimtex_view_automatic = 0
    vim.g.vimtex_compiler_latexmk = {
        aux_dir = "temp",
        out_dir = "build",
        continuous = true,
    }
end

return M
