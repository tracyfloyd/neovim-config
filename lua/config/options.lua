vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!

vim.opt.inccommand = "split" -- Preview substitutions as you type

vim.opt.scrolloff = 10 -- Minimum number of screen lines to keep above and below the cursor

--vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

--opt.clipboard:append("unnamedplus") -- use system clipboard as default register

vim.opt.splitright = true -- Split vertical window to the right

vim.opt.splitbelow = true -- Split horizontal window to the bottom

--vim.opt.swapfile = false -- Turn off swapfile

vim.opt.undofile = true -- Store undos between sessions

-- Line Numbers ===============================================================
vim.opt.number = true -- Shows absolute line number on cursor line (when relative number is on)
vim.opt.relativenumber = true -- Show relative line numbers

-- Tabs & Indentation =========================================================
vim.opt.autoindent = true -- Copy indent from current line when starting new one
vim.opt.breakindent = true -- If the line needs to wrap, indent it if needed
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Amount to indent with << and >>
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line
vim.opt.smarttab = true -- Make deleting "tabbed spaces" easier
vim.opt.softtabstop = 4 -- Spaces applied when pressing Tab
vim.opt.tabstop = 4 -- Spaces shown per Tab
vim.opt.wrap = false -- Disable line wrapping

-- Search =====================================================================
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Appearance =================================================================
vim.opt.background = "dark" -- Colorschemes that can be light or dark will be made dark
vim.opt.cursorline = true -- Highlight the current cursor line
vim.opt.list = true -- Show whitespace characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Show whitespace characters as
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.signcolumn = "yes" -- Reserve a space in the gutter to avoid layout shift
vim.opt.termguicolors = true -- Turn on termguicolors for nightfly colorscheme to work
vim.opt.winborder = "rounded" -- Enable rounded corners in floating windows

-- Code Folding ===============================================================
vim.opt.foldcolumn = "1"
vim.opt.foldenable = true
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
-- vim.opt.foldnestmax = 4
-- vim.opt.foldtext = ""
