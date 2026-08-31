local M = {}

local function executable_exists(name)
    return vim.fn.executable(name) == 1
end

local function file_exists(path)
    return vim.fn.filereadable(path) == 1
end

local function configure_pdf_viewer()
    if vim.fn.has("win32") == 1 then
        if executable_exists("SumatraPDF") then
            return
        end

        -- SumatraPDF exists, but isn't in PATH.
        local sumatra = vim.fn.expand("~/AppData/Local/SumatraPDF/SumatraPDF.exe")
        if file_exists(sumatra) then
            vim.g.vimtex_view_method = "general"
            vim.g.vimtex_view_general_viewer = sumatra
            vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
            return
        end
    elseif vim.fn.has("unix") == 1 then
        if executable_exists("zathura") then
            vim.g.vimtex_view_method = "zathura"
            return
        end

        if executable_exists("mupdf") then
            vim.g.vimtex_view_method = "mupdf"
            return
        end
    end
end

function M.custom_setup()
    configure_pdf_viewer()

    vim.g.vimtex_mappings_prefix = "<localleader>v"
    vim.g.vimtex_view_automatic = 0
    vim.g.vimtex_compiler_latexmk = {
        aux_dir = "temp",
        out_dir = "build",
        continuous = true,
    }
end

return M
