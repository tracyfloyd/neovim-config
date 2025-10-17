vim.g.mapleader = " "

-- Go to file listing
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


-- Disable arrow keys in insert mode with a styled message
--vim.keymap.set('i', '<Up>', "'Use k'<CR>")
--vim.keymap.set('i', '<Down>', "'Use j'<CR>")
--vim.keymap.set('i', '<Left>', "'Use h'<CR>")
--vim.keymap.set('i', '<Right>', "'Use l'<CR>")
-- Disable arrow keys in normal mode with a styled message
--vim.keymap.set('n', '<Up>', ":echoe 'Use k'<CR>")
--vim.keymap.set('n', '<Down>', ":echoe 'Use j'<CR>")
--vim.keymap.set('n', '<Left>', ":echoe 'Use h'<CR>")
--vim.keymap.set('n', '<Right>', ":echoe 'Use l'<CR>")


vim.opt.mouse = 'a'
vim.opt.scrolloff = 10

-- line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

vim.opt.wrap = false -- disable line wrapping

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

vim.opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes" -- Reserve a space in the gutter to avoid layout shift

-- backspace
--vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
--opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
--vim.opt.swapfile = false

-- Code folding
-- vim.opt.foldcolumn = "0"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
-- vim.opt.foldnestmax = 4
-- vim.opt.foldtext = ""
vim.opt.foldenable = true
vim.opt.foldcolumn = "1"

-- Enable rounded corners in floating windows
vim.opt.winborder = "rounded"

vim.lsp.enable({
  'antlersls',
  'cssls',
  'intelephense',
  'lua-language-server',
})

-- Add noselect to completeopt, otherwise autocompletion is annoying
vim.cmd("set completeopt+=noselect")

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- Configure the LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})


require("config.lazy")


