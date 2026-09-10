-- Conform
-- Code formatter
-- @link https://github.com/stevearc/conform.nvim

return {
  'stevearc/conform.nvim',
  enabled = true,

  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ async = false })
      end,
      mode = '',
      desc = 'Conform: Format current buffer',
    },
  },

  ---@module "conform"
  ---@type conform.setupOpts
  config = function()
    require('conform').setup({
      -- formatters by filetype
      formatters_by_ft = {
        css = { 'prettierd', stop_after_first = true },
        scss = { 'prettierd', stop_after_first = true },
        html = { 'prettierd', stop_after_first = true },

        json = { 'prettierd', stop_after_first = true },
        yaml = { 'prettierd', stop_after_first = true },
        -- prettier defaults to proseWrap: preserve, so this reflows syntax but
        -- not prose. Drop it if it still fights your markdown.
        markdown = { 'prettierd', stop_after_first = true },

        lua = { 'stylua' },

        php = { 'pint' },

        javascript = { 'prettierd', stop_after_first = true },
        typescript = { 'prettierd', stop_after_first = true },
        typescriptreact = { 'prettierd', stop_after_first = true },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        lsp_format = 'fallback',
        timeout_ms = 10000,
      },
    })
  end,
}
