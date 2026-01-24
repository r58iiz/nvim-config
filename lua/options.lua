local HOME = vim.env.HOME or vim.env.USERPROFILE

-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- disable providers
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

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

vim.wo.foldenable = true
vim.wo.foldlevel = 0
vim.wo.foldcolumn = "0"

vim.wo.wrap = true
vim.o.eol = true
vim.wo.cursorline = true
vim.o.list = false

-- custom
local tabsNumber = 4
vim.bo.softtabstop = tabsNumber
vim.bo.textwidth = 120
vim.o.smarttab = true
vim.o.showmode = true
vim.wo.colorcolumn = [[120]]
vim.o.completeopt = [[menuone,noinsert,noselect]]

-- Sidebar
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.numberwidth = 3
vim.wo.signcolumn = "yes"
vim.o.modelines = 0
vim.o.showcmd = true

-- Search
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.matchtime = 2
vim.o.mps = vim.o.mps .. ",<:>"

-- White characters
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.tabstop = tabsNumber
vim.bo.shiftwidth = tabsNumber
vim.bo.formatoptions = "qnj1"
-- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
vim.bo.expandtab = true

-- Backup files
vim.o.backup = true
vim.o.undofile = true
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.undoreload = 10000
vim.o.undodir = vim.fs.joinpath(vim.fn.stdpath("state"), "tmp", "undo", "/")
vim.o.backupdir = vim.fs.joinpath(vim.fn.stdpath("state"), "tmp", "backup", "/")
-- vim.o.directory = HOME .. "/.config/nvim/tmp/swap//"           -- swap files

-- Commands mode
vim.o.wildmenu = true
vim.o.wildignore =
    "deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc"
