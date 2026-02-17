vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- ======================================================================================
-- Appearance
vim.opt.background = 'dark' -- Colorschemes that can be light or dark will be made dark
-- vim.opt.cmdheight = 0 -- Hide command line unless being used - disabled as it messes with Lualine
-- vim.opt.colorcolumn = '100' -- Show column at 100 characters
vim.opt.completeopt = 'menuone,noinsert,noselect' -- Completion options
vim.opt.cursorcolumn = true -- Highlight the screen column of the cursor
vim.opt.cursorline = true -- Highlight the current cursor line
vim.opt.cursorlineopt = 'screenline' --
-- vim.opt.guicursor = 'n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'
vim.opt.laststatus = 3 -- Enable a single, persistent status line at the bottom of the screen for all splits
vim.opt.list = true -- Show white-space characters
vim.opt.listchars = { -- Show whitespace characters as
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}
vim.opt.matchtime = 2 -- How long to show matching brackets
vim.opt.number = true -- Line numbers
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.pumheight = 10 -- Popup Menu Height: Set the max-popup height to 10 items.
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 10 -- Lines to keep above/below cursor
vim.opt.showmatch = true -- Highlight martching brackets
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.shortmess:append('F') -- Prevent showing filetype in the command line when opening a file
vim.opt.sidescrolloff = 8 -- Columns to keep left/right of cursor
vim.opt.signcolumn = 'yes:2' -- Reserve a space in the gutter to avoid layout shift
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.winblend = 0 -- Floating window transparency
vim.opt.winborder = 'rounded' -- Enable rounded corners in floating windows
vim.opt.wrap = false -- Line wrapping

-- ======================================================================================
-- Indentation
vim.opt.autoindent = true -- Copy indent from current line when starting new one
vim.opt.breakindent = true -- If the line needs to wrap, indent it if needed
vim.opt.copyindent = true --
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Amount to indent with << and >>
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line
vim.opt.smarttab = true -- Make deleting "tabbed spaces" easier
vim.opt.softtabstop = 4 -- Spaces applied when pressing Tab
vim.opt.tabstop = 4 -- Spaces shown per Tab
vim.opt.wrap = false -- Enable line wrapping

-- ======================================================================================
-- Search
vim.opt.hlsearch = false -- Don't Highlight search results
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.incsearch = true -- Show matches as you type
vim.opt.smartcase = true -- Case sensitive search if uppercase used in search term

-- ======================================================================================
-- Code Folding
vim.opt.fillchars:append({ fold = ' ' })
vim.opt.foldcolumn = '0'
vim.opt.foldenable = true -- set to false to disable folding everything on startup if needed
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99
-- vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldtext = ''

-- ======================================================================================
-- File Handling & Performance
vim.opt.autoread = true -- Auto reload files changed outside of Neovim
vim.opt.autowrite = false -- Don't auto save
vim.opt.backup = false -- Don't create backup files
vim.opt.maxmempattern = 20000 -- Maximum amount of memory (in Kbyte) to use for pattern matching
vim.opt.mousemoveevent = true -- Allow hovering in bufferline
vim.opt.redrawtime = 10000 -- Allow more time for loading syntax on large files
vim.opt.swapfile = false -- Don't create swap files
vim.opt.timeoutlen = 500 -- Timeout Length: This is the time Neovim waits for the completion of a key sequence.
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.updatetime = 300 -- Faster completion
vim.opt.writebackup = false -- Don't create backup before writing

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand('~/.vim/undodir')
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end
vim.opt.undodir = vim.fn.expand('~/.vim/undodir') -- Undo directory
vim.opt.undofile = true -- Store undos between sessions

-- ======================================================================================
-- Behavior
vim.opt.autochdir = false -- Don't auto change directory
vim.opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line or insert mode start position
vim.opt.clipboard:append('unnamedplus') -- use system clipboard as default register
vim.opt.encoding = 'UTF-8' -- Set encoding
vim.opt.errorbells = false -- No error bells
-- vim.opt.hidden = true -- Allow hidden buffers
vim.opt.inccommand = 'split' -- Preview substitutions as you type
vim.opt.iskeyword:append('-') -- Treat dash as part of word
vim.opt.modifiable = true -- Allow buffer modifications
vim.opt.mouse = 'a' -- Enable mouse mode
vim.opt.path:append('**') -- Include subdirectories in search
vim.opt.selection = 'exclusive' -- Selection behavior
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
vim.opt.splitbelow = true -- Split horizontal window to the bottom
vim.opt.splitright = true -- Split vertical window to the right
vim.opt.wildmenu = true -- Enable enhanced command-line completion
vim.opt.wildmode = 'longest:full,full' -- Completion mode
vim.opt.wildignore:append({ '*.o', '*.obj', '*.pyc', '*.class', '*.jar' }) -- Add to completion matching ignore list
