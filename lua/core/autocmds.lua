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

-- -- Function to apply dimming to inactive windows
-- local function dim_inactive_windows()
--   -- Link NormalNC (non-current window normal text) to a dimmer highlight group
--   -- 'Comment' is a good choice for a dimmer, built-in color
--   vim.api.nvim_set_hl(0, 'NormalNC', { link = 'Comment' })
-- end
--
-- -- Function to restore normal highlights for the active window
-- local function restore_active_window()
--   -- Remove the link for Normal, restoring its default highlight
--   vim.api.nvim_set_hl(0, 'NormalNC', {})
-- end
--
-- -- Autocmds to manage highlights on focus events
-- vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
--   callback = restore_active_window,
-- })
--
-- vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
--   callback = dim_inactive_windows,
-- })
