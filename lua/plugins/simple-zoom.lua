-- Simple Zoom
-- A simple plugin to add a Tmux-like zoom functionality to Neovim.
-- @link https://github.com/fasterius/simple-zoom.nvim

return {
  'fasterius/simple-zoom.nvim',
  enabled = true,

  keys = {
    { '<C-w>z', '<Cmd>SimpleZoomToggle<CR>', mode = { 'n' }, desc = 'Zoom toggle' },
  },

  config = function()
    require('simple-zoom').setup({
      hide_tabline = false,
    })
  end,
}
