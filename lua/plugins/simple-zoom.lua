-- Simple Zoom
-- A simple plugin to add a Tmux-like zoom functionality to Neovim.
--
-- @link https://github.com/fasterius/simple-zoom.nvim

return {
  'fasterius/simple-zoom.nvim',
  opts = {
    hide_tabline = false,
  },
  keys = {
    { '<Leader>z', '<Cmd>SimpleZoomToggle<CR>', mode = { 'n' }, desc = 'Zoom toggle' },
  },
}
