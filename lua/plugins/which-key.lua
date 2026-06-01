-- Which Key
-- Assistant that shows key binds on key presses.
-- @link https://github.com/folke/which-key.nvim

return {
  'folke/which-key.nvim',
  enabled = true,

  event = 'VeryLazy',

  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },

  config = function()
    require('which-key').setup({
      win = {
        padding = { 1, 1 },
      },
    })
  end,

}
