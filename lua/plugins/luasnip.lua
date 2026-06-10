-- LuaSnip
-- Snippet engine. Loads VSCode-format snippets (friendly-snippets) and user
-- Lua snippets from lua/snippets/<filetype>.lua.
-- @link https://github.com/L3MON4D3/LuaSnip

return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_lua').lazy_load({
      paths = vim.fn.stdpath('config') .. '/lua/snippets',
    })
  end,
}
