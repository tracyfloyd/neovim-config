-- Multiple cursors
-- @link https://github.com/mg979/vim-visual-multi

return {
  'brenton-leighton/multiple-cursors.nvim',
  enabled = true,

  version = '*', -- Use the latest tagged version

  keys = {
    -- <C-j>/<C-k> are not used here: core/keymaps.lua binds them to window
    -- navigation and, being required after lazy.setup, wins -- these entries
    -- never fired. <C-Up>/<C-Down> below cover the same two actions.

    { '<C-Up>', '<Cmd>MultipleCursorsAddUp<CR>', mode = { 'n', 'i', 'x' }, desc = 'Add cursor and move up' },
    { '<C-Down>', '<Cmd>MultipleCursorsAddDown<CR>', mode = { 'n', 'i', 'x' }, desc = 'Add cursor and move down' },

    { '<C-LeftMouse>', '<Cmd>MultipleCursorsMouseAddDelete<CR>', mode = { 'n', 'i' }, desc = 'Add or remove cursor' },

    { '<Leader>m', '<Cmd>MultipleCursorsAddVisualArea<CR>', mode = { 'x' }, desc = 'Add cursors to the lines of the visual area' },

    { '<Leader>a', '<Cmd>MultipleCursorsAddMatches<CR>', mode = { 'n', 'x' }, desc = 'Add cursors to cword' },
    { '<Leader>A', '<Cmd>MultipleCursorsAddMatchesV<CR>', mode = { 'n', 'x' }, desc = 'Add cursors to cword in previous area' },

    { '<Leader>d', '<Cmd>MultipleCursorsAddJumpNextMatch<CR>', mode = { 'n', 'x' }, desc = 'Add cursor and jump to next cword' },
    { '<Leader>D', '<Cmd>MultipleCursorsJumpNextMatch<CR>', mode = { 'n', 'x' }, desc = 'Jump to next cword' },

    { '<Leader>l', '<Cmd>MultipleCursorsLock<CR>', mode = { 'n', 'x' }, desc = 'Lock virtual cursors' },
  },

  config = function()
    require('multiple-cursors').setup({})
  end,
}
