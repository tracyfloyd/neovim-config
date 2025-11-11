-- cmp-nvim-lsp
-- Adds Neovim's built-in language server client as a completion source for nvim-cmp.
-- @link https://github.com/hrsh7th/cmp-nvim-lsp

return {
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
}
