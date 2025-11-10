-- mason
-- Package Manager for LSP servers, DAP servers, linters, and formatters.
-- @link https://github.com/mason-org/mason.nvim

return {
  {
    'mason-org/mason-lspconfig.nvim',

    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        'antlersls',
        'ts_ls',
        'html',
        'cssls',
        'svelte',
        'lua_ls',
        'graphql',
        'emmet_ls',
      },
    },
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          ui = {
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        },
      },

      { 'neovim/nvim-lspconfig' },

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },
    },
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'prettier', -- prettier formatter
        'stylua', -- lua formatter
        'eslint_d',
      },
    },
    dependencies = {
      'williamboman/mason.nvim',
    },
  },
}
