-- mason.nvim
-- Package Manager to install and manage LSP servers, DAP servers, linters, and formatters.
-- @link https://github.com/mason-org/mason.nvim
return {
  'mason-org/mason.nvim',
  config = function()
    require('mason').setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry',
      },
    })
  end,
}
