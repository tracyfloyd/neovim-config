-- Highlight Colors
-- Realtime color highlighting (for strings, hex codes, css vars, etc)
-- @link https://github.com/brenoprata10/nvim-highlight-colors

return {
  'brenoprata10/nvim-highlight-colors',
  enabled = true,

  config = function()
    require('nvim-highlight-colors').setup({
      render = 'virtual', -- 'background'|'foreground'|'virtual'
      enable_var_usage = true,

      -- Keep this matched with the built-in LSP swatch in lua/plugins/lsp.lua.
      virtual_symbol = '●',

      -- Escape-sequence colors in logs and terminal dumps. Off by default in
      -- the plugin, despite what its README example shows.
      enable_ansi = true, -- '\033[0;34m'
      enable_xterm256 = true, -- '\033[38;5;118m'
      enable_xtermTrueColor = true, -- '\033[38;2;118;64;90m'

      -- nvim 0.12 renders LSP document colors itself (see lua/plugins/lsp.lua),
      -- and this plugin also requests textDocument/documentColor, so any
      -- filetype with a colorProvider-capable server attached gets two swatches.
      -- Exclude those: cssls/somesass_ls/css_variables cover the css family,
      -- and vscode-html-language-server advertises colorProvider for html, php
      -- and templ. Everything else (lua, json, blade, logs, ...) has no
      -- documentColor provider, which is what this plugin is still here for.
      exclude_filetypes = { 'css', 'html', 'less', 'php', 'sass', 'scss', 'templ' },
    })
  end,
}
