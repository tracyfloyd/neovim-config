return {

  {
    -- Nvim LSP Config
    -- A collection of LSP server configurations for Neovim.
    -- @link https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'saghen/blink.cmp' },
      { 'j-hui/fidget.nvim' },
      { 'mason-org/mason.nvim' },
      { 'mason-org/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    },
    config = function()
      -- local capabilities = require('blink.cmp').get_lsp_capabilities()
      if vim.fn.has('nvim-0.11') == 1 and vim.lsp.config then
        vim.lsp.config('*', {
          capabilities = require('blink.cmp').get_lsp_capabilities(),
        })
      end

      -- require('lspconfig').lua_ls.setup { capabilities = capabilities }
      vim.lsp.inlay_hint.enable(true)

      -- TODO: Is this the right place for this Diagnostic Config?

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ', -- ' ',
            [vim.diagnostic.severity.WARN] = '󰀪 ', -- ' ',
            [vim.diagnostic.severity.HINT] = '󰋽 ', -- '󰠠 ',
            [vim.diagnostic.severity.INFO] = '󰌶 ', -- ' ',
          },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })
    end,
  },

  -- Tiny Inline Diagnostic
  -- Inline diagnostic messages with customizable styles and icons.
  -- @link https://github.com/rachartier/tiny-inline-diagnostic.nvim
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup({
        preset = 'powerline',
        show_source = {
          enabled = true,
        },
      })
      vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
    end,
  },

  -- Fidget
  -- Provides Neovim/LSP notification window in the bottom right corner
  -- @link https://github.com/mason-org/mason-lspconfig.nvim
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup({})
    end,
  },

  {
    -- Mason
    -- Package Manager to install and manage LSP servers, DAP servers, linters, and formatters.
    -- @link https://github.com/mason-org/mason.nvim
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
      })
    end,
  },

  {
    -- Mason LSP Config
    -- Bridges `mason.nvim` with the nvim-lspconfig  making it easier to use both plugins together.
    -- @link https://github.com/mason-org/mason-lspconfig.nvim
    'mason-org/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {}, -- explicitly set to an empty table (Installs via mason-tool-installer)
      })
    end,
  },

  {
    -- Mason Tool Installer
    -- @link https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = {
          'cssls',
          'emmet_language_server',
          'eslint_d',
          'html',
          'lua_ls',
          'prettierd',
          'stylua',
          'ts_ls',
        },
      })
    end,
  },
}
