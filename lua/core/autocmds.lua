local augroup = vim.api.nvim_create_augroup('UserConfig', {})

-- ======================================================================================
-- Text Editing

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Trim trailing whitespace on save',
  group = augroup,
  pattern = '*',
  command = ':%s/\\s\\+$//e',
})

-- Highlight when yanking text
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Nvim terminal customizations
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Customize Nvim Terminal',
  group = augroup,
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- Use treesitter for folding if it has parser for filetype
vim.api.nvim_create_autocmd({ 'FileType' }, {
  callback = function()
    -- check if treesitter has parser
    if require('nvim-treesitter.parsers').has_parser() then
      -- use treesitter folding
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    else
      -- use alternative foldmethod
      vim.opt.foldmethod = 'syntax'
    end
  end,
})

-- Refresh folds when entering a buffer.
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = { '*' },
  command = 'normal! zx',
})

-- ======================================================================================
-- LSP

-- Runs when an LSP attaches to a buffer.
-- When a file is opened and associated with an LSP, this function
-- will be executed to configure the current buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- set keybinds
    opts.desc = 'LSP: Show documentation for what is under cursor'
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = 'LSP: Show definition'
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    opts.desc = 'LSP: Show available code actions'
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- in visual mode will apply to selection

    opts.desc = 'LSP/Telescope: Show references'
    vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

    opts.desc = 'LSP/Telescope: Show implementations'
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

    opts.desc = 'LSP/Telescope: Show type definitions'
    vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

    opts.desc = 'LSP: Go to declaration'
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    opts.desc = 'LSP: Smart rename'
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)

    opts.desc = 'LSP: Restart LSP'
    vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary

    -- Diagnostics
    opts.desc = 'LSP: Show line diagnostics in float'
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

    opts.desc = 'LSP/Telescope: Show buffer diagnostics'
    vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

    opts.desc = 'LSP: Go to previous diagnostic'
    vim.keymap.set('n', '[d', function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts) -- jump to previous diagnostic in buffer

    opts.desc = 'LSP: Go to next diagnostic'
    vim.keymap.set('n', ']d', function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts) -- jump to next diagnostic in buffer
  end,
})

-- ======================================================================================
-- File Management

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Return to last edit position when opening files',
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    local line = mark[1]
    local ft = vim.bo.filetype
    if line > 0 and line <= lcount and vim.fn.index({ 'commit', 'gitrebase', 'xxd' }, ft) == -1 and not vim.o.diff then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Create directories when saving files',
  group = augroup,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Set filetype to razor for .cshtml files
vim.api.nvim_create_autocmd('BufRead', {
  desc = 'Set filetype for .cshtml files',
  group = vim.api.nvim_create_augroup('detect_cshtml', { clear = true }),
  pattern = { '.cshtml' },
  callback = function()
    vim.cmd('set filetype=razor')
  end,
})

-- ======================================================================================
-- Window Management

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Auto-resize splits when window is resized',
  group = augroup,
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- ======================================================================================
-- Adjust wrapping behavior for markdown and text files
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'markdown', 'text', 'gitcommit' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})
