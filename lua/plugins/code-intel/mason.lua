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
        'github:mason-org/mason-registry', -- Added for https://github.com/seblyng/roslyn.nvim
        'github:Crashdummyy/mason-registry', -- Added for https://github.com/seblyng/roslyn.nvim
      },
    })
  end,
}
