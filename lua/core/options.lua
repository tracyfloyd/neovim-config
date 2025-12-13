vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!

vim.opt.inccommand = 'split' -- Preview substitutions as you type

-- vim.opt.scrolloff = 10 -- Minimum number of screen lines to keep above and below the cursor

--vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

vim.opt.clipboard:append('unnamedplus') -- use system clipboard as default register

vim.opt.splitright = true -- Split vertical window to the right
vim.opt.splitbelow = true -- Split horizontal window to the bottom

--vim.opt.swapfile = false -- Turn off swapfile

vim.opt.undofile = false -- Store undos between sessions

vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Line Numbers ===============================================================
vim.opt.number = true -- Shows absolute line number on cursor line (when relative number is on)
vim.opt.relativenumber = true -- Show relative line numbers

-- Tabs & Indentation =========================================================
vim.opt.autoindent = true -- Copy indent from current line when starting new one
vim.opt.copyindent = true
vim.opt.breakindent = true -- If the line needs to wrap, indent it if needed
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Amount to indent with << and >>
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line
vim.opt.smarttab = true -- Make deleting "tabbed spaces" easier
vim.opt.softtabstop = 4 -- Spaces applied when pressing Tab
vim.opt.tabstop = 4 -- Spaces shown per Tab
vim.opt.wrap = false -- Enable line wrapping

-- Search =====================================================================
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Appearance =================================================================
vim.opt.background = 'dark' -- Colorschemes that can be light or dark will be made dark
vim.opt.cmdheight = 0 -- Hide comamnd line unless its being used
vim.opt.cursorline = true -- Highlight the current cursor line
vim.opt.cursorlineopt = 'screenline'
vim.opt.cursorcolumn = true
vim.opt.list = true -- Show white-space characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- Show whitespace characters as
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.signcolumn = 'yes:2' -- Reserve a space in the gutter to avoid layout shift
vim.opt.termguicolors = true
vim.opt.winborder = 'rounded' -- Enable rounded corners in floating windows
-- Set up the highlight groups
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#45475b', bg = '#ffffff' })
-- this command sets ver split border... need to make this automatic   :hi WinSeparator guifg=#45475b
-- vim.opt.cmdheight = 0 -- Hide command bar unless is being used

-- Code Folding ===============================================================
vim.opt.foldcolumn = '0'
vim.opt.foldenable = true -- set to false to disable folding everything on startup if needed
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldtext = ''
vim.opt.fillchars:append({ fold = ' ' })

vim.opt.updatetime = 100 -- Decrease update time
vim.opt.redrawtime = 10000 -- Allow more time for loading syntax on large files
vim.opt.mousemoveevent = true -- Allow hovering in bufferline
vim.opt.timeoutlen = 300 -- Timeout Length: This is the time Neovim waits for the completion of a key sequence.
vim.opt.pumheight = 5 -- Popup Menu Height: Set the max-popup height to 5 items.

--[[
-- Keymaps to explore... from https://vale.rocks/posts/neovim
-- If I’m opening and closing brackets, there is a reasonable assumption that I wish to enter them, so I have binds that place my cursor within them after creating them. The same applies to quotes and backticks.
map("i", "<>", "<><left>", { desc = "Enter into angled brackets" })
map("i", "()", "()<left>", { desc = "Enter into round brackets" })
map("i", "{}", "{}<left>", { desc = "Enter into curly brackets" })
map("i", "[]", "[]<left>", { desc = "Enter into square brackets" })
map("i", '""', '""<left>', { desc = "Enter into double quotes" })
map("i", "''", "''<left>", { desc = "Enter into single quotes" })
map("i", "``", "``<left>", { desc = "Enter into backticks" })

-- When I move around the screen, I want to move by the lines on the screen, not arbitrary lines of the document. This isn’t generally an issue, but becomes one when I have line wrapping enabled.
map({ "n", "v" }, "<Up>", "gk", { desc = "Move up a screenline" })
map({ "n", "v" }, "<Down>", "gj", { desc = "Move down a screenline" })
map("i", "<Up>", "<C-o>gk", { desc = "Move up a screenline" })
map("i", "<Down>", "<C-o>gj", { desc = "Move down a screenline" })


-- I dislike how creating a new line above or below the current one changes the mode to insert, so I edit the commands to also perform an escape afterwards.
map('n', 'O', "O<Esc>", { desc = "Append empty line" })
map('n', 'o', "o<Esc>", { desc = "Prepend empty line" })

-- When I delete something, I don’t want it to copy, so I disable that functionality.
-- Instead should look to mapping SHIFT X to delete - and leave x as the default cut?
map({"n", "v"}, "x", '"_x')
map({"n", "v"}, "X", '"_X')
]]
