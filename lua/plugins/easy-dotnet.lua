-- easy dotnet
--
-- Makes working with dotnet in Neovim better
--
-- @link https://github.com/GustavEikaas/easy-dotnet.nvim

return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    require('easy-dotnet').setup()
  end,
}
