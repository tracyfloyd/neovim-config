-- nvim-highlight-colors
--
-- Highlight colors
--
-- @link https://github.com/brenoprata10/nvim-highlight-colors

return {
  'brenoprata10/nvim-highlight-colors',
  config = function()
    require('nvim-highlight-colors').setup({
      render = 'background', -- 'background'|'foreground'|'virtual'
      enable_var_usage = true,
    })
  end,
}
