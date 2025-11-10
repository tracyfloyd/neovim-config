-- Better code folding
-- @link https://github.com/kevinhwang91/nvim-ufo

return {
  'kevinhwang91/nvim-ufo',

  event = 'BufReadPost',

  dependencies = {
    'kevinhwang91/promise-async',
  },

  opts = {
    provider_selector = function()
      return { 'lsp', 'indent' }
    end,
  },

  keys = {
    {
      'zR',
      function()
        require('ufo').openAllFolds()
      end,
    },
    {
      'zM',
      function()
        require('ufo').closeAllFolds()
      end,
    },
  },

  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local language_servers = vim.lsp.get_clients()
    for _, ls in ipairs(language_servers) do
      require('lspconfig')[ls].setup({
        capabilities = capabilities,
        -- you can add other fields for setting up lsp server in this table
      })
    end
    require('ufo').setup()
  end,
}
