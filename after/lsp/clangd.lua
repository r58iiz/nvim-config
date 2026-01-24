-- vim.lsp.config("clangd", {})
return {
    filetypes = { "c", "cpp" },
    root_markers = {
        ".clangd",
        "compile_commands.json",
        "compile_flags.txt",
    },
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--enable-config",
        "--function-arg-placeholders=true",
        "--header-insertion=never",
        "--inlay-hints",
        "--pretty",
    },
    settings = {
        completions = {
            completeFunctionCalls = true,
        },
    },
    init_options = {
        fallbackFlags = {
            -- "-xc",
            "-std=c99",
            "-U_FORTIFY_SOURCE",
            "-D_FORTIFY_SOURCE=3",
            "-D_GLIBCXX_ASSERTIONS",
            "-fstrict-flex-arrays=3",
            "-O2",
            "-Wall",
            "-Wbad-function-cast",
            "-Wcast-align",
            "-Wconversion",
            "-Werror",
            "-Wextra",
            "-Wformat",
            "-Wformat=2",
            "-Wimplicit-fallthrough",
            "-Wpedantic",
            "-Wpointer-arith",
            "-Wshadow",
            "-Wstrict-prototypes",
            "-Wswitch-default",
            "-Wswitch-enum",
            "-Wundef",
        },
    },
}
--[[
    https://blog.quarkslab.com/clang-hardening-cheat-sheet-ten-years-later.html
    https://best.openssf.org/Compiler-Hardening-Guides/Compiler-Options-Hardening-Guide-for-C-and-C++.html
]]
