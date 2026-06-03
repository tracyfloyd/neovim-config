-- Fugitive
-- GIT tooling inside Neovim
-- @link https://github.com/tpope/vim-fugitive

return {
  'tpope/vim-fugitive',
  enabled = true,

  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
  end,
}
