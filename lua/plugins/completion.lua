-- blink.cmp
--
-- Code Completion Engine
--
-- @link https://github.com/saghen/blink.cmp
return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    enabled = true,

    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
      },
      'rafamadriz/friendly-snippets',
    },

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
        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
      },
      signature = { enabled = true },
      snippets = { preset = 'luasnip' },
      appearance = { nerd_font_variant = 'mono' },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      sources = {
        default = { 'snippets', 'lsp', 'path', 'buffer' },
        providers = {
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
    opts_extend = { 'sources.default' },
  },
}
