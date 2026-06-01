-- Nvim Surround
-- Add/delete/change surrounding pairs
-- @link https://github.com/kylechui/nvim-surround

return {
  'kylechui/nvim-surround',
  enabled = false,

  version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
  event = 'VeryLazy',

  config = function()
    require('nvim-surround').setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
