-- vimspectr-dark, a vim theme by nightsense
-- https://github.com/nightsense/vimspectr
--
-- generated with a theme template adapted from base16-vim by Chris Kempson
-- https://github.com/chriskempson/base16-vim
--
-- Ported by Claude

-- vimspectr-dark colorscheme for Neovim (Lua)
-- Supports multiple hues via vim.g.vimspectr_hue
-- Valid values: "grey" | "0" | "30" ... "330"  (default: "grey")
--
-- Usage in init.lua:
--   vim.g.vimspectr_hue = "0"       -- warm red tint
--   vim.g.vimspectr_hue = "grey"    -- neutral grey (default)
--   vim.cmd("colorscheme vimspectr-dark")

vim.cmd("hi clear")
vim.cmd("syntax reset")
vim.g.colors_name = "vimspectr-dark"

-- Palette definitions — only g0..g7 vary per hue;
-- accent colours (g8..gF) and cterm indices are shared across all hues.
local palettes = {
    grey = {
        g0 = "#141414",
        g1 = "#2b2b2b",
        g2 = "#6b6b6b",
        g3 = "#6b6b6b",
        g4 = "#8a8a8a",
        g5 = "#8a8a8a",
        g6 = "#e8e8e8",
        g7 = "#ffffff",
        -- terminal colours
        tc0 = "#141414",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#8a8a8a",
        tc8 = "#6b6b6b",
        tc9 = "#b5734c",
        tc10 = "#2b2b2b",
        tc11 = "#6b6b6b",
        tc12 = "#8a8a8a",
        tc13 = "#e8e8e8",
        tc14 = "#b57988",
        tc15 = "#ffffff",
    },
    ["0"] = {
        g0 = "#1f1212",
        g1 = "#332222",
        g2 = "#806060",
        g3 = "#806060",
        g4 = "#997f7f",
        g5 = "#997f7f",
        g6 = "#f0dddd",
        g7 = "#fff5f5",
        -- terminal colours
        tc0 = "#1f1212",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#997f7f",
        tc8 = "#806060",
        tc9 = "#b5734c",
        tc10 = "#332222",
        tc11 = "#806060",
        tc12 = "#997f7f",
        tc13 = "#f0dddd",
        tc14 = "#b57988",
        tc15 = "#fff5f5",
    },
    ["30"] = {
        g0 = "#1a140f",
        g1 = "#302820",
        g2 = "#756758",
        g3 = "#756758",
        g4 = "#918579",
        g5 = "#918579",
        g6 = "#ede4da",
        g7 = "#fffaf5",
        -- terminal colours
        tc0 = "#1a140f",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#918579",
        tc8 = "#756758",
        tc9 = "#b5734c",
        tc10 = "#302820",
        tc11 = "#756758",
        tc12 = "#918579",
        tc13 = "#ede4da",
        tc14 = "#b57988",
        tc15 = "#fffaf5",
    },
    ["60"] = {
        g0 = "#17170d",
        g1 = "#2b2b1d",
        g2 = "#6e6e52",
        g3 = "#6e6e52",
        g4 = "#8a8a72",
        g5 = "#8a8a72",
        g6 = "#ebebd8",
        g7 = "#fffff5",
        -- terminal colours
        tc0 = "#17170d",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#8a8a72",
        tc8 = "#6e6e52",
        tc9 = "#b5734c",
        tc10 = "#2b2b1d",
        tc11 = "#6e6e52",
        tc12 = "#8a8a72",
        tc13 = "#ebebd8",
        tc14 = "#b57988",
        tc15 = "#fffff5",
    },
    ["90"] = {
        g0 = "#12170d",
        g1 = "#262e1f",
        g2 = "#627054",
        g3 = "#627054",
        g4 = "#808c74",
        g5 = "#808c74",
        g6 = "#e1ebd8",
        g7 = "#fafff5",
        -- terminal colours
        tc0 = "#12170d",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#808c74",
        tc8 = "#627054",
        tc9 = "#b5734c",
        tc10 = "#262e1f",
        tc11 = "#627054",
        tc12 = "#808c74",
        tc13 = "#e1ebd8",
        tc14 = "#b57988",
        tc15 = "#fafff5",
    },
    ["120"] = {
        g0 = "#0d170d",
        g1 = "#1f2e1f",
        g2 = "#547054",
        g3 = "#547054",
        g4 = "#778f77",
        g5 = "#778f77",
        g6 = "#d8ebd8",
        g7 = "#f5fff5",
        -- terminal colours
        tc0 = "#0d170d",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#778f77",
        tc8 = "#547054",
        tc9 = "#b5734c",
        tc10 = "#1f2e1f",
        tc11 = "#547054",
        tc12 = "#778f77",
        tc13 = "#d8ebd8",
        tc14 = "#b57988",
        tc15 = "#f5fff5",
    },
    ["150"] = {
        g0 = "#0d1712",
        g1 = "#1f2e26",
        g2 = "#547062",
        g3 = "#547062",
        g4 = "#778f83",
        g5 = "#778f83",
        g6 = "#d8ebe1",
        g7 = "#f5fffa",
        -- terminal colours
        tc0 = "#0d1712",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#778f83",
        tc8 = "#547062",
        tc9 = "#b5734c",
        tc10 = "#1f2e26",
        tc11 = "#547062",
        tc12 = "#778f83",
        tc13 = "#d8ebe1",
        tc14 = "#b57988",
        tc15 = "#f5fffa",
    },
    ["180"] = {
        g0 = "#0d1717",
        g1 = "#1f2e2e",
        g2 = "#547070",
        g3 = "#547070",
        g4 = "#748c8c",
        g5 = "#748c8c",
        g6 = "#d8ebeb",
        g7 = "#f5ffff",
        -- terminal colours
        tc0 = "#0d1717",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#748c8c",
        tc8 = "#547070",
        tc9 = "#b5734c",
        tc10 = "#1f2e2e",
        tc11 = "#547070",
        tc12 = "#748c8c",
        tc13 = "#d8ebeb",
        tc14 = "#b57988",
        tc15 = "#f5ffff",
    },
    ["210"] = {
        g0 = "#10161c",
        g1 = "#202830",
        g2 = "#5a6978",
        g3 = "#5a6978",
        g4 = "#7b8794",
        g5 = "#7b8794",
        g6 = "#dde6f0",
        g7 = "#f5faff",
        -- terminal colours
        tc0 = "#10161c",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#7b8794",
        tc8 = "#5a6978",
        tc9 = "#b5734c",
        tc10 = "#202830",
        tc11 = "#5a6978",
        tc12 = "#7b8794",
        tc13 = "#dde6f0",
        tc14 = "#b57988",
        tc15 = "#f5faff",
    },
    ["240"] = {
        g0 = "#151524",
        g1 = "#242436",
        g2 = "#636385",
        g3 = "#636385",
        g4 = "#81819c",
        g5 = "#81819c",
        g6 = "#dfdff2",
        g7 = "#f5f5ff",
        -- terminal colours
        tc0 = "#151524",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#81819c",
        tc8 = "#636385",
        tc9 = "#b5734c",
        tc10 = "#242436",
        tc11 = "#636385",
        tc12 = "#81819c",
        tc13 = "#dfdff2",
        tc14 = "#b57988",
        tc15 = "#f5f5ff",
    },
    ["270"] = {
        g0 = "#1a1321",
        g1 = "#2d2436",
        g2 = "#706080",
        g3 = "#706080",
        g4 = "#8c7f99",
        g5 = "#8c7f99",
        g6 = "#e9dff2",
        g7 = "#faf5ff",
        -- terminal colours
        tc0 = "#1a1321",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#8c7f99",
        tc8 = "#706080",
        tc9 = "#b5734c",
        tc10 = "#2d2436",
        tc11 = "#706080",
        tc12 = "#8c7f99",
        tc13 = "#e9dff2",
        tc14 = "#b57988",
        tc15 = "#faf5ff",
    },
    ["300"] = {
        g0 = "#1f121f",
        g1 = "#332233",
        g2 = "#7d5e7d",
        g3 = "#7d5e7d",
        g4 = "#967d96",
        g5 = "#967d96",
        g6 = "#f0ddf0",
        g7 = "#fff5ff",
        -- terminal colours
        tc0 = "#1f121f",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#967d96",
        tc8 = "#7d5e7d",
        tc9 = "#b5734c",
        tc10 = "#332233",
        tc11 = "#7d5e7d",
        tc12 = "#967d96",
        tc13 = "#f0ddf0",
        tc14 = "#b57988",
        tc15 = "#fff5ff",
    },
    ["330"] = {
        g0 = "#1f1218",
        g1 = "#33222b",
        g2 = "#7d5e6d",
        g3 = "#7d5e6d",
        g4 = "#997f8c",
        g5 = "#997f8c",
        g6 = "#f0dde6",
        g7 = "#fff5fa",
        -- terminal colours
        tc0 = "#1f1218",
        tc1 = "#b55a4c",
        tc2 = "#6d8a50",
        tc3 = "#b59b4c",
        tc4 = "#6a849e",
        tc5 = "#8b6a9e",
        tc6 = "#508a82",
        tc7 = "#997f8c",
        tc8 = "#7d5e6d",
        tc9 = "#b5734c",
        tc10 = "#33222b",
        tc11 = "#7d5e6d",
        tc12 = "#997f8c",
        tc13 = "#f0dde6",
        tc14 = "#b57988",
        tc15 = "#fff5fa",
    },
}

-- Shared accent colours (same across all hues)
local accent = {
    g8 = "#b55a4c", -- red
    g9 = "#b5734c", -- orange
    gA = "#b59b4c", -- yellow
    gB = "#6d8a50", -- green
    gC = "#508a82", -- teal
    gD = "#6a849e", -- blue
    gE = "#8b6a9e", -- purple
    gF = "#b57988", -- pink
}

-- Shared cterm indices
local t = {
    t0 = 0,
    t1 = 10,
    t2 = 11,
    t3 = 8,
    t4 = 12,
    t5 = 7,
    t6 = 13,
    t7 = 15,
    t8 = 1,
    t9 = 9,
    tA = 3,
    tB = 2,
    tC = 6,
    tD = 4,
    tE = 5,
    tF = 14,
}

-- Resolve hue
local hue = tostring(vim.g.vimspectr_hue or "grey")
local p = palettes[hue]
if not p then
    vim.notify(("vimspectr-dark: unknown hue %q, falling back to 'grey'"):format(hue), vim.log.levels.WARN)
    p = palettes["grey"]
end

-- Merge palette + accents into a single colour table
local g = vim.tbl_extend("force", p, accent)

-- Set terminal colours
for i = 0, 15 do
    vim.g["terminal_color_" .. i] = p["tc" .. i]
end

-- Helper: use default if unset
local function opt(name, default)
    local v = vim.g[name]
    return v == nil and default or v
end

-- Helper: set highlight group
local function h(group, fg, bg, ctermfg, ctermbg, attr, sp)
    local opts = {}
    if fg ~= "" then
        opts.fg = fg
    end
    if bg ~= "" then
        opts.bg = bg
    end
    if ctermfg ~= 0 then
        opts.ctermfg = ctermfg
    end
    if ctermbg ~= 0 then
        opts.ctermbg = ctermbg
    end
    if sp ~= "" then
        opts.sp = sp
    end
    if attr ~= "" and attr ~= "none" then
        for _, a in ipairs(vim.split(attr, ",")) do
            opts[a] = true
        end
    end
    vim.api.nvim_set_hl(0, group, opts)
end

local e = "" -- empty sentinel

-- Base colours: muted fg
h("Comment", g.g2, e, t.t2, 0, "none", e)
h("Conceal", g.g2, e, t.t2, 0, "none", e)
h("CursorLineNr", g.g0, g.g2, t.t0, t.t2, "none", e)
h("DiffChange", g.g2, g.g0, t.t2, t.t0, "none", e)
h("EndOfBuffer", g.g2, e, t.t2, 0, "none", e)
h("Ignore", g.g2, e, t.t2, 0, "none", e)
h("NonText", g.g2, e, t.t2, 0, "none", e)

-- Base colours: standard fg
h("Bold", e, e, 0, 0, "bold", e)
h("Cursor", g.g0, g.g5, t.t0, t.t5, "none", e)
h("Directory", g.g5, e, t.t5, 0, "bold", e)
h("Italic", e, e, 0, 0, "italic", e)
h("Normal", g.g5, g.g0, t.t5, t.t0, "none", e)
h("StatusLine", g.g0, g.g5, t.t0, t.t5, "none", e)
h("StatusLineTerm", g.g0, g.g5, t.t0, t.t5, "none", e)
h("TabLineSel", g.g0, g.g5, t.t0, t.t5, "none", e)
h("TermCursor", g.g0, g.g5, t.t0, t.t5, "none", e)
h("Underlined", g.g5, e, t.t5, 0, "underline", e)

-- Base colours: highlighted bg
h("ColorColumn", e, g.g1, 0, t.t1, "none", e)
h("CursorColumn", e, g.g1, 0, t.t1, "none", e)
h("CursorLine", e, g.g1, 0, t.t1, "none", e)
h("FoldColumn", g.g5, g.g1, t.t5, t.t1, "none", e)
h("Folded", g.g5, g.g1, t.t5, t.t1, "none", e)
h("LineNr", g.g5, g.g1, t.t5, t.t1, "none", e)
h("MatchParen", e, g.g1, 0, t.t1, "none", e)
h("QuickFixLine", e, g.g1, 0, t.t1, "none", e)
h("SignColumn", g.g5, g.g1, t.t5, t.t1, "none", e)
h("StatusLineNC", g.g5, g.g1, t.t5, t.t1, "none", e)
h("StatusLineTermNC", g.g5, g.g1, t.t5, t.t1, "none", e)
h("TabLine", g.g5, g.g1, t.t5, t.t1, "none", e)
h("TabLineFill", e, g.g1, 0, t.t1, "none", e)
h("TermCursorNC", e, g.g1, 0, t.t1, "none", e)
h("VisualNOS", g.g5, g.g1, t.t5, t.t1, "none", e)

-- Base colours: extra-highlighted bg
h("Pmenu", g.g6, g.g2, t.t6, t.t2, "none", e)
h("PmenuSel", g.g0, g.g6, t.t0, t.t6, "none", e)
h("Visual", g.g6, g.g2, t.t6, t.t2, "none", e)
h("WildMenu", g.g0, g.g6, t.t0, t.t6, "none", e)

-- Base colours: solid lines
h("PmenuSbar", g.g1, g.g1, t.t1, t.t1, "none", e)
h("PmenuThumb", g.g5, g.g5, t.t5, t.t5, "none", e)
h("VertSplit", g.g2, g.g2, t.t2, t.t2, "none", e)

-- Syntax: red = warning
h("DiffDelete", g.g8, g.g0, t.t8, t.t0, "none", e)
h("DiffRemoved", g.g8, e, t.t8, 0, "none", e)
h("Error", g.g8, g.g0, t.t8, t.t0, "reverse", e)
h("ErrorMsg", g.g8, g.g0, t.t8, t.t0, "none", e)
h("SpellBad", e, e, t.t0, t.t8, "undercurl", g.g8)
h("TooLong", g.g8, e, t.t8, 0, "none", e)
h("WarningMsg", g.g8, g.g0, t.t8, t.t0, "none", e)

-- Syntax: orange = preliminary
h("Define", g.g9, e, t.t9, 0, "none", e)
h("DiffChanged", g.g9, e, t.t9, 0, "none", e)
h("DiffText", g.g9, g.g0, t.t9, t.t0, "none", e)
h("IncSearch", g.g9, g.g0, t.t9, t.t0, "reverse", e)
h("Include", g.g9, e, t.t9, 0, "none", e)
h("Macro", g.g9, e, t.t9, 0, "none", e)
h("PreCondit", g.g9, e, t.t9, 0, "none", e)
h("PreProc", g.g9, e, t.t9, 0, "none", e)
h("SpellCap", e, e, t.t0, t.t9, "undercurl", g.g9)
h("Title", g.g9, e, t.t9, 0, "none", e)

-- Syntax: yellow = highlight
h("Search", g.gA, g.g0, t.tA, t.t0, "reverse", e)
h("Todo", g.gA, g.g0, t.tA, t.t0, "reverse", e)

-- Syntax: green = action
h("Conditional", g.gB, e, t.tB, 0, "none", e)
h("DiffAdd", g.gB, g.g0, t.tB, t.t0, "none", e)
h("DiffAdded", g.gB, e, t.tB, 0, "none", e)
h("Exception", g.gB, e, t.tB, 0, "none", e)
h("Keyword", g.gB, e, t.tB, 0, "none", e)
h("Label", g.gB, e, t.tB, 0, "none", e)
h("ModeMsg", g.gB, e, t.tB, 0, "none", e)
h("MoreMsg", g.gB, e, t.tB, 0, "none", e)
h("Operator", g.gB, e, t.tB, 0, "none", e)
h("Question", g.gB, e, t.tB, 0, "none", e)
h("Repeat", g.gB, e, t.tB, 0, "none", e)
h("Statement", g.gB, e, t.tB, 0, "none", e)

-- Syntax: teal = type
h("SpellLocal", e, e, t.t0, t.tC, "undercurl", g.gC)
h("StorageClass", g.gC, e, t.tC, 0, "none", e)
h("Structure", g.gC, e, t.tC, 0, "none", e)
h("Type", g.gC, e, t.tC, 0, "none", e)
h("Typedef", g.gC, e, t.tC, 0, "none", e)

-- Syntax: blue = constant
h("Boolean", g.gD, e, t.tD, 0, "none", e)
h("Character", g.gD, e, t.tD, 0, "none", e)
h("Constant", g.gD, e, t.tD, 0, "none", e)
h("Float", g.gD, e, t.tD, 0, "none", e)
h("Number", g.gD, e, t.tD, 0, "none", e)
h("String", g.gD, e, t.tD, 0, "none", e)

-- Syntax: purple = special
h("Debug", g.gE, e, t.tE, 0, "none", e)
h("Delimiter", g.gE, e, t.tE, 0, "none", e)
h("Special", g.gE, e, t.tE, 0, "none", e)
h("SpecialChar", g.gE, e, t.tE, 0, "none", e)
h("SpecialComment", g.gE, e, t.tE, 0, "none", e)
h("SpecialKey", g.gE, e, t.tE, 0, "none", e)
h("SpellRare", e, e, t.t0, t.tE, "undercurl", g.gE)
h("Tag", g.gE, e, t.tE, 0, "none", e)

-- Syntax: pink = name
h("Function", g.gF, e, t.tF, 0, "none", e)
h("Identifier", g.gF, e, t.tF, 0, "none", e)

-- Options (g:vimspectr* tuning variables - same as before)
local cursorlinenr = opt("vimspectrCursorLineNr", true)
local mutelinenr = opt("vimspectrMuteLineNr", false)
local linenr = opt("vimspectrLineNr", true)
local mutesl = opt("vimspectrMuteStatusLine", false)
local italiccomment = opt("vimspectrItalicComment", false)

if not cursorlinenr then
    h("CursorLineNr", g.g5, g.g1, t.t5, t.t1, "none", e)
end

if mutelinenr then
    h("LineNr", g.g2, g.g1, t.t2, t.t1, "none", e)
    if not cursorlinenr then
        h("CursorLineNr", g.g2, g.g1, t.t2, t.t1, "none", e)
    end
end

if not linenr then
    h("CursorLineNr", g.g5, g.g0, t.t5, t.t0, "none", e)
    h("LineNr", g.g5, g.g0, t.t5, t.t0, "none", e)
    if mutelinenr then
        h("CursorLineNr", g.g2, g.g0, t.t2, t.t0, "none", e)
        h("LineNr", g.g2, g.g0, t.t2, t.t0, "none", e)
    end
end

if mutesl then
    h("StatusLine", g.g0, g.g2, t.t0, t.t2, "none", e)
end

if italiccomment then
    h("Comment", g.g2, e, t.t2, 0, "italic", e)
end
