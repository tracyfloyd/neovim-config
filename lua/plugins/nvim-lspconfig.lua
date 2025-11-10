return {

  -- nvim-lspconfig
  -- A collection of LSP server configurations for Neovim.
  -- @link https://github.com/neovim/nvim-lspconfig
  {
    'neovim/nvim-lspconfig',

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

      {
        'mason-org/mason-lspconfig.nvim',
        opts = {},
      },

      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
          ensure_installed = {
            -- LSP
            'antlersls',
            'ts_ls',
            'html',
            'cssls',
            'svelte',
            'lua_ls',
            'graphql',
            'emmet_ls',

            -- Linters
            'eslint_d',

            -- Formatters
            'prettier',
            'stylua',
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
          opts.desc = 'Show LSP references'
          vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

          opts.desc = 'Go to declaration'
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

          opts.desc = 'Show LSP definition'
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

          opts.desc = 'Show LSP implementations'
          vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

          opts.desc = 'Show LSP type definitions'
          vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

          opts.desc = 'See available code actions'
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- in visual mode will apply to selection

          opts.desc = 'Smart rename'
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

          opts.desc = 'Show buffer diagnostics'
          vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

          opts.desc = 'Show line diagnostics'
          vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

          opts.desc = 'Go to previous diagnostic'
          vim.keymap.set('n', '[d', function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, opts) -- jump to previous diagnostic in buffer

          opts.desc = 'Go to next diagnostic'
          vim.keymap.set('n', ']d', function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, opts) -- jump to next diagnostic in buffer

          opts.desc = 'Show documentation for what is under cursor'
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

          opts.desc = 'Restart LSP'
          vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary
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
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = '󰠠 ',
            [vim.diagnostic.severity.INFO] = ' ',
          },
        } or {},
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

  -- nvim-cmp
  -- Code Completion Engine
  -- @link https://github.com/hrsh7th/nvim-cmp
  { -- nvim-cmp
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer', -- Source for text in current buffer
      'hrsh7th/cmp-path', -- Source for file system paths
      'L3MON4D3/LuaSnip', -- Snippet engine
      {
        'L3MON4D3/LuaSnip', -- Snippet engine
        build = 'make install_jsregexp',
      },
      'saadparwaiz1/cmp_luasnip', -- Source for snippet engine snippets
      'rafamadriz/friendly-snippets', -- Useful snippets for various languages
      'onsails/lspkind.nvim', -- vs-code like pictograms
    },

    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require('luasnip.loaders.from_vscode').lazy_load()

      --luasnip.config.setup({})

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      --require("render-markdown").setup({
      --    completions = { lsp = { enabled = true } },
      --})

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = 'menu,menuone,preview,noselect',
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
          ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
          ['<C-e>'] = cmp.mapping.abort(), -- close completion window

          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          --['<CR>'] = cmp.mapping.confirm({
          --  behavior = cmp.ConfirmBehavior.Replace,
          --  select = true,
          --}),

          --[[
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ]]

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        }),

        -- Sources for autocompletion
        -- Note: The order of these dictates priority of recommendations
        sources = {
          -- {
          --     name = "lazydev",
          --     group_index = 0, -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          -- },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' }, -- snippets
          { name = 'buffer' }, -- text within current buffer
          { name = 'path' }, -- file system paths
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text', -- options: "text", "text_symbol", "symbol_text", "symbol"
            preset = 'default', -- option: "default", "material", "devicons"
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50, -- leading text (labelDetails)
              abbr = 50, -- actual suggestion item
            },
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              -- ...
              return vim_item
            end,
          }),
        },
      }) -- end cmp.setup()
    end,
  },

  -- cmp-nvim-lsp
  -- Support for Neovim's built-in language server client
  -- @link https://github.com/hrsh7th/cmp-nvim-lsp
  {
    'hrsh7th/cmp-nvim-lsp',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- When files are renamed, update references in code (if LSP supports it)
      { 'antosha417/nvim-lsp-file-operations', config = true },

      -- Configure Lua LSP for working on Neovim config
      { 'folke/lazydev.nvim', opts = {} },
    },
    config = function()
      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require('cmp_nvim_lsp')

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())

      -- used to enable autocompletion (assign to every lsp server config)
      -- local capabilities = cmp_nvim_lsp.default_capabilities()

      vim.lsp.config('*', {
        capabilities = capabilities,
      })
    end,
  },
}
