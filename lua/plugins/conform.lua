-- Conform (Code formatter)
--
-- @link https://github.com/stevearc/conform.nvim

return {
  'stevearc/conform.nvim',

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
  opts = {
    -- formatters by filetype
    formatters_by_ft = {
      css = { 'prettierd', 'prettier', stop_after_first = true },
      scss = { 'prettierd', 'prettier', stop_after_first = true },

      php = { 'pint' },

      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
  },
}
