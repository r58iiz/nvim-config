-- vimspectr-light, a vim theme by haystackandroid
-- https://github.com/haystackandroid/vimspectr
--
-- generated with a theme template adapted from base16-vim by Chris Kempson
-- https://github.com/chriskempson/base16-vim
--
-- Ported by Claude

-- vimspectr-light colorscheme for Neovim (Lua)
-- Supports multiple hues via vim.g.vimspectr_hue
-- Valid values: "grey" | "0" | "30" ... "330"  (default: "grey")
--
-- Usage in init.lua:
--   vim.g.vimspectr_hue = "0"       -- warm red tint
--   vim.g.vimspectr_hue = "grey"    -- neutral grey (default)
--   vim.cmd("colorscheme vimspectr-light")

vim.cmd("hi clear")
vim.cmd("syntax reset")
vim.g.colors_name = "vimspectr-light"

-- Palette definitions — only g0..g7 vary per hue;
-- accent colours (g8..gF) and cterm indices are shared across all hues.
local palettes = {
    grey = {
        g0 = "#ffffff",
        g1 = "#e8e8e8",
        g2 = "#8a8a8a",
        g3 = "#8a8a8a",
        g4 = "#6b6b6b",
        g5 = "#6b6b6b",
        g6 = "#2b2b2b",
        g7 = "#141414",
        -- terminal colours
        tc0 = "#ffffff",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#6b6b6b",
        tc8 = "#8a8a8a",
        tc9 = "#e07638",
        tc10 = "#e8e8e8",
        tc11 = "#8a8a8a",
        tc12 = "#6b6b6b",
        tc13 = "#2b2b2b",
        tc14 = "#e0708c",
        tc15 = "#141414",
    },
    ["0"] = {
        g0 = "#fff5f5",
        g1 = "#f0dddd",
        g2 = "#997f7f",
        g3 = "#997f7f",
        g4 = "#806060",
        g5 = "#806060",
        g6 = "#332222",
        g7 = "#1f1212",
        -- terminal colours
        tc0 = "#fff5f5",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#806060",
        tc8 = "#997f7f",
        tc9 = "#e07638",
        tc10 = "#f0dddd",
        tc11 = "#997f7f",
        tc12 = "#806060",
        tc13 = "#332222",
        tc14 = "#e0708c",
        tc15 = "#1f1212",
    },
    ["30"] = {
        g0 = "#fffaf5",
        g1 = "#ede4da",
        g2 = "#918579",
        g3 = "#918579",
        g4 = "#756758",
        g5 = "#756758",
        g6 = "#302820",
        g7 = "#1a140f",
        -- terminal colours
        tc0 = "#fffaf5",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#756758",
        tc8 = "#918579",
        tc9 = "#e07638",
        tc10 = "#ede4da",
        tc11 = "#918579",
        tc12 = "#756758",
        tc13 = "#302820",
        tc14 = "#e0708c",
        tc15 = "#1a140f",
    },
    ["60"] = {
        g0 = "#fffff5",
        g1 = "#ebebd8",
        g2 = "#8a8a72",
        g3 = "#8a8a72",
        g4 = "#6e6e52",
        g5 = "#6e6e52",
        g6 = "#2b2b1d",
        g7 = "#17170d",
        -- terminal colours
        tc0 = "#fffff5",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#6e6e52",
        tc8 = "#8a8a72",
        tc9 = "#e07638",
        tc10 = "#ebebd8",
        tc11 = "#8a8a72",
        tc12 = "#6e6e52",
        tc13 = "#2b2b1d",
        tc14 = "#e0708c",
        tc15 = "#17170d",
    },
    ["90"] = {
        g0 = "#fafff5",
        g1 = "#e1ebd8",
        g2 = "#808c74",
        g3 = "#808c74",
        g4 = "#627054",
        g5 = "#627054",
        g6 = "#262e1f",
        g7 = "#12170d",
        -- terminal colours
        tc0 = "#fafff5",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#627054",
        tc8 = "#808c74",
        tc9 = "#e07638",
        tc10 = "#e1ebd8",
        tc11 = "#808c74",
        tc12 = "#627054",
        tc13 = "#262e1f",
        tc14 = "#e0708c",
        tc15 = "#12170d",
    },
    ["120"] = {
        g0 = "#f5fff5",
        g1 = "#d8ebd8",
        g2 = "#778f77",
        g3 = "#778f77",
        g4 = "#547054",
        g5 = "#547054",
        g6 = "#1f2e1f",
        g7 = "#0d170d",
        -- terminal colours
        tc0 = "#f5fff5",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#547054",
        tc8 = "#778f77",
        tc9 = "#e07638",
        tc10 = "#d8ebd8",
        tc11 = "#778f77",
        tc12 = "#547054",
        tc13 = "#1f2e1f",
        tc14 = "#e0708c",
        tc15 = "#0d170d",
    },
    ["150"] = {
        g0 = "#f5fffa",
        g1 = "#d8ebe1",
        g2 = "#778f83",
        g3 = "#778f83",
        g4 = "#547062",
        g5 = "#547062",
        g6 = "#1f2e26",
        g7 = "#0d1712",
        -- terminal colours
        tc0 = "#f5fffa",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#547062",
        tc8 = "#778f83",
        tc9 = "#e07638",
        tc10 = "#d8ebe1",
        tc11 = "#778f83",
        tc12 = "#547062",
        tc13 = "#1f2e26",
        tc14 = "#e0708c",
        tc15 = "#0d1712",
    },
    ["180"] = {
        g0 = "#f5ffff",
        g1 = "#d8ebeb",
        g2 = "#748c8c",
        g3 = "#748c8c",
        g4 = "#547070",
        g5 = "#547070",
        g6 = "#1f2e2e",
        g7 = "#0d1717",
        -- terminal colours
        tc0 = "#f5ffff",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#547070",
        tc8 = "#748c8c",
        tc9 = "#e07638",
        tc10 = "#d8ebeb",
        tc11 = "#748c8c",
        tc12 = "#547070",
        tc13 = "#1f2e2e",
        tc14 = "#e0708c",
        tc15 = "#0d1717",
    },
    ["210"] = {
        g0 = "#f5faff",
        g1 = "#dde6f0",
        g2 = "#7b8794",
        g3 = "#7b8794",
        g4 = "#5a6978",
        g5 = "#5a6978",
        g6 = "#202830",
        g7 = "#10161c",
        -- terminal colours
        tc0 = "#f5faff",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#5a6978",
        tc8 = "#7b8794",
        tc9 = "#e07638",
        tc10 = "#dde6f0",
        tc11 = "#7b8794",
        tc12 = "#5a6978",
        tc13 = "#202830",
        tc14 = "#e0708c",
        tc15 = "#10161c",
    },
    ["240"] = {
        g0 = "#f5f5ff",
        g1 = "#dfdff2",
        g2 = "#81819c",
        g3 = "#81819c",
        g4 = "#636385",
        g5 = "#636385",
        g6 = "#242436",
        g7 = "#151524",
        -- terminal colours
        tc0 = "#f5f5ff",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#636385",
        tc8 = "#81819c",
        tc9 = "#e07638",
        tc10 = "#dfdff2",
        tc11 = "#81819c",
        tc12 = "#636385",
        tc13 = "#242436",
        tc14 = "#e0708c",
        tc15 = "#151524",
    },
    ["270"] = {
        g0 = "#faf5ff",
        g1 = "#e9dff2",
        g2 = "#8c7f99",
        g3 = "#8c7f99",
        g4 = "#706080",
        g5 = "#706080",
        g6 = "#2d2436",
        g7 = "#1a1321",
        -- terminal colours
        tc0 = "#faf5ff",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#706080",
        tc8 = "#8c7f99",
        tc9 = "#e07638",
        tc10 = "#e9dff2",
        tc11 = "#8c7f99",
        tc12 = "#706080",
        tc13 = "#2d2436",
        tc14 = "#e0708c",
        tc15 = "#1a1321",
    },
    ["300"] = {
        g0 = "#fff5ff",
        g1 = "#f0ddf0",
        g2 = "#967d96",
        g3 = "#967d96",
        g4 = "#7d5e7d",
        g5 = "#7d5e7d",
        g6 = "#332233",
        g7 = "#1f121f",
        -- terminal colours
        tc0 = "#fff5ff",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#7d5e7d",
        tc8 = "#967d96",
        tc9 = "#e07638",
        tc10 = "#f0ddf0",
        tc11 = "#967d96",
        tc12 = "#7d5e7d",
        tc13 = "#332233",
        tc14 = "#e0708c",
        tc15 = "#1f121f",
    },
    ["330"] = {
        g0 = "#fff5fa",
        g1 = "#f0dde6",
        g2 = "#997f8c",
        g3 = "#997f8c",
        g4 = "#7d5e6d",
        g5 = "#7d5e6d",
        g6 = "#33222b",
        g7 = "#1f1218",
        -- terminal colours
        tc0 = "#fff5fa",
        tc1 = "#e04d38",
        tc2 = "#699e34",
        tc3 = "#e0b738",
        tc4 = "#4286c9",
        tc5 = "#a565c9",
        tc6 = "#349e90",
        tc7 = "#7d5e6d",
        tc8 = "#997f8c",
        tc9 = "#e07638",
        tc10 = "#f0dde6",
        tc11 = "#997f8c",
        tc12 = "#7d5e6d",
        tc13 = "#33222b",
        tc14 = "#e0708c",
        tc15 = "#1f1218",
    },
}

-- Shared accent colours (same across all hues)
local accent = {
    g8 = "#e04d38", -- red
    g9 = "#e07638", -- orange
    gA = "#e0b738", -- yellow
    gB = "#699e34", -- green
    gC = "#349e90", -- teal
    gD = "#4286c9", -- blue
    gE = "#a565c9", -- purple
    gF = "#e0708c", -- pink
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
    vim.notify(("vimspectr-light: unknown hue %q, falling back to 'grey'"):format(hue), vim.log.levels.WARN)
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
h("Search", g.gA, g.g6, t.tA, t.t6, "reverse", e)
h("Todo", g.gA, g.g6, t.tA, t.t6, "reverse", e)

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
