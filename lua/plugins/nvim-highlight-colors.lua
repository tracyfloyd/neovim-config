-- Highlight Colors
-- Realtime color highlighting (for strings, hex codes, css vars, etc)
-- @link https://github.com/brenoprata10/nvim-highlight-colors

return {
  'brenoprata10/nvim-highlight-colors',
  enabled = true,

  config = function()
    require('nvim-highlight-colors').setup({
      render = 'virtual', -- 'background'|'foreground'|'virtual'
      enable_var_usage = true,
    })
  end,
}
