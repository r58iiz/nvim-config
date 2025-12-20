local HOME = vim.env.HOME or vim.env.USERPROFILE

-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- set shell
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.opt.shell = "powershell"
    vim.opt.shellcmdflag = "-NoLogo -NoProfile -Command"
    vim.opt.shellredir = "'| Out-File -Encoding UTF8 %s'"
    vim.opt.shellpipe = "'| Out-File -Encoding UTF8 %s'"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

-- Disable LSP logging
vim.lsp.set_log_level("OFF")

-- basic settings
vim.o.encoding = "utf-8"
vim.o.backspace = "indent,eol,start"
vim.o.history = 1000
vim.opt.timeoutlen = 500

-- Tabline
vim.opt.showtabline = 2

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Display
vim.o.cmdheight = 1
vim.o.showmatch = true
vim.o.scrolloff = 5
vim.o.synmaxcol = 300
vim.o.laststatus = 2

vim.o.foldenable = true
vim.o.foldlevel = 0
vim.o.foldcolumn = "0"
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.wrap = true
vim.o.eol = true
vim.o.cursorline = true
vim.o.list = false

-- custom
local tabsNumber = 4
vim.o.softtabstop = tabsNumber
vim.o.textwidth = 120
vim.o.smarttab = true
vim.o.showmode = true
vim.o.colorcolumn = [[120]]
vim.o.completeopt = [[menuone,noinsert,noselect]]

-- Sidebar
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 3
vim.o.signcolumn = "yes"
vim.o.modelines = 0
vim.o.showcmd = true

-- Search
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.matchtime = 2
vim.o.mps = vim.o.mps .. ",<:>"

-- White characters
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = tabsNumber
vim.o.shiftwidth = tabsNumber
vim.o.formatoptions = "qnj1"
-- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
vim.o.expandtab = true

-- Backup files
vim.o.backup = true
vim.o.undofile = true
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.undoreload = 10000
vim.o.undodir = HOME .. "/.config/nvim/tmp/undo//"
vim.o.backupdir = HOME .. "/.config/nvim/tmp/backup//"
-- vim.o.directory = HOME .. "/.config/nvim/tmp/swap//"           -- swap files

-- Commands mode
vim.o.wildmenu = true
vim.o.wildignore =
    "deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc"
