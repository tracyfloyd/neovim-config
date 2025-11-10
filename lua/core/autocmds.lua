-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Trim trailing whitespace on save',
  pattern = '*',
  command = ':%s/\\s\\+$//e',
})

-- Highlight on yank
-- Try it with `yap` in normal mode
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }), -- TODO Rename this group?
  callback = function()
    vim.highlight.on_yank()
  end,
})
