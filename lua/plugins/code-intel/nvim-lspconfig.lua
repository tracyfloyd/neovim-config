-- nvim-lspconfig
--
-- A collection of LSP server configurations for Neovim.
--
-- @link https://github.com/neovim/nvim-lspconfig

return {
  'neovim/nvim-lspconfig',

  dependencies = {
    {
      -- mason.nvim
      -- Package Manager to install and manage LSP servers, DAP servers, linters, and formatters.
      -- @link https://github.com/mason-org/mason.nvim
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

    {
      -- mason-lspconfig.nvim
      -- Bridges `mason.nvim` with the nvim-lspconfig  making it easier to use both plugins together.
      -- @link https://github.com/mason-org/mason-lspconfig.nvim
      'mason-org/mason-lspconfig.nvim',
      opts = {
        ensure_installed = {}, -- explicitly set to an empty table (Installs via mason-tool-installer)
      },
    },

    {
      -- mason-tool-installer
      -- @link https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      opts = {
        ensure_installed = {
          'cssls',
          -- 'emmet_language_server',
          'eslint_d',
          'graphql',
          'html',
          'lua_ls',
          'prettier',
          'stylua',
          'svelte',
          'ts_ls',
        },
      },
    },

    -- Useful status updates for LSP
    {
      'j-hui/fidget.nvim',
      opts = {},
    },
  },

  config = function()
    -- Runs when an LSP attaches to a buffer.
    -- When a file is opened that is associated withan LSP, this function
    -- will be executed to configure the current buffer.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = 'LSP: Show documentation for what is under cursor'
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = 'LSP: Show definition'
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

        opts.desc = 'LSP: Show available code actions'
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- in visual mode will apply to selection

        opts.desc = 'LSP/Telescope: Show references'
        vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

        opts.desc = 'LSP/Telescope: Show implementations'
        vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

        opts.desc = 'LSP/Telescope: Show type definitions'
        vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

        opts.desc = 'LSP: Go to declaration'
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        opts.desc = 'LSP: Smart rename'
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)

        opts.desc = 'LSP: Restart LSP'
        vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary

        -- Diagnostics
        opts.desc = 'LSP/Telescope: Show buffer diagnostics'
        vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

        opts.desc = 'LSP: Show line diagnostics'
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

        opts.desc = 'LSP: Go to previous diagnostic'
        vim.keymap.set('n', '[d', function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, opts) -- jump to previous diagnostic in buffer

        opts.desc = 'LSP: Go to next diagnostic'
        vim.keymap.set('n', ']d', function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, opts) -- jump to next diagnostic in buffer
      end,
    })

    -- vim.lsp.inlay_hint.enable(true)

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
}
