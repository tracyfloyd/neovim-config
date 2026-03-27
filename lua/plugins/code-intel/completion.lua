-- blink.cmp
--
-- Code Completion Engine
--
-- @link https://github.com/saghen/blink.cmp
return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    enabled = true,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      keymap = { preset = 'default' },
      signature = {
        enabled = true,
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      sources = {
        default = { 'lsp', 'easy-dotnet', 'path' },
        providers = {
          ['easy-dotnet'] = {
            name = 'easy-dotnet',
            enabled = true,
            module = 'easy-dotnet.completion.blink',
            score_offset = 10000,
            async = true,
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
