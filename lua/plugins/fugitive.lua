-- Fugitive
-- GIT tooling inside Neovim
-- @link https://github.com/tpope/vim-fugitive

return {
  'tpope/vim-fugitive',
  enabled = true,

  cmd = { 'G', 'Git', 'Gdiffsplit', 'Gread', 'Gwrite', 'Gedit', 'GBrowse' },
  keys = {
    { '<leader>gs', '<cmd>Git<CR>', desc = 'Fugitive: git status' },
  },
}
