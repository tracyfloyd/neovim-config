vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Highlight the current cursor line
vim.opt.cursorline = true

-- Preview substitutions as you type
vim.opt.inccommand = "split"

-- Minimum number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Backspace
--vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- Clipboard
--opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Split vertical window to the right
vim.opt.splitright = true

-- Split horizontal window to the bottom
vim.opt.splitbelow = true

-- Turn off swapfile
--vim.opt.swapfile = false

-- Store undos between sessions
vim.opt.undofile = true

-- Line Numbers ===============================================================

-- Shows absolute line number on cursor line (when relative number is on)
vim.opt.number = true

-- Show relative line numbers
vim.opt.relativenumber = true

-- Tabs & Indentation =========================================================

-- Spaces shown per Tab
vim.opt.tabstop = 2

-- Spaces applied when pressing Tab
vim.opt.softtabstop = 2

-- Amount to indent with << and >>
vim.opt.shiftwidth = 2

-- Convert tabs to spaces
vim.opt.expandtab = true

-- Copy indent from current line when starting new one
vim.opt.autoindent = true

--
vim.opt.smarttab = true

-- Do smart autoindenting when starting a new line
vim.opt.smartindent = true

-- Keep indentation from previous line
vim.opt.autoindent = true

-- Disable line wrapping
vim.opt.wrap = false

-- If the line needs to wrap, indent it if needed
vim.opt.breakindent = true

-- Search =====================================================================

vim.opt.smartcase = true

-- Appearance =================================================================

-- Colorschemes that can be light or dark will be made dark
vim.opt.background = "dark"

-- Disable command line until it is needed
-- vim.opt.cmdheight = 0

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Reserve a space in the gutter to avoid layout shift
vim.opt.signcolumn = "yes"

-- Turn on termguicolors for nightfly colorscheme to work
vim.opt.termguicolors = true

-- Enable rounded corners in floating windows
vim.opt.winborder = "rounded"

-- Code Folding ===============================================================
-- vim.opt.foldcolumn = "0"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
-- vim.opt.foldnestmax = 4
-- vim.opt.foldtext = ""
vim.opt.foldenable = true
vim.opt.foldcolumn = "1"
