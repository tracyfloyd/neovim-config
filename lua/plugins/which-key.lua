-- which-key.nvim
--
-- Assistant that shows key binds on key presses.
--
-- @link https://github.com/folke/which-key.nvim

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    win = {
      padding = { 1, 1 },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
