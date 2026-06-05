-- Blink
-- Code Completion Engine
-- @link https://github.com/saghen/blink.cmp

return {
  {
    'saghen/blink.cmp',
    enabled = true,

    dependencies = {
      'saghen/blink.lib',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
      },
      'rafamadriz/friendly-snippets',
    },

    build = function()
      -- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
      -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
      require('blink.cmp').build():pwait()
    end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      keymap = {
        preset = 'default',
        -- ['<C-l>'] = { 'snippet_forward', 'fallback' },
        -- ['<C-h>'] = { 'snippet_backward', 'fallback' },
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      signature = { enabled = true },
      snippets = { preset = 'luasnip' },
      appearance = { nerd_font_variant = 'mono' },
      fuzzy = { implementation = 'rust' },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          -- ['blade-nav'] = {
          --   name = 'blade-nav',
          --   module = 'blade-nav.integrations.blink',
          -- },
          path = {
            opts = {
              -- Always use the CWD rather than the current
              -- buffer's parent directory
              get_cwd = function(_)
                return vim.fn.getcwd()
              end,
              show_hidden_files_by_default = true,
              trailing_slash = false,
            },
          },
        },
      },
    },
  },
}
