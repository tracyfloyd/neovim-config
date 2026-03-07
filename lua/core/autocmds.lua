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
