-- tint.nvim
--
-- Tint inactive windows in Neovim using window-local highlight namespaces.
--
-- @link https://github.com/levouh/tint.nvim

return {
  'levouh/tint.nvim',
  config = function()
    require('tint').setup({
      tint = -55, -- Darken colors, use a positive value to brighten
      saturation = 0.4, -- Saturation to preserve
    })
  end,
}
