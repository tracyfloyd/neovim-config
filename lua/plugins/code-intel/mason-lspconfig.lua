-- mason-lspconfig.nvim
-- Bridges `mason.nvim` with the nvim-lspconfig  making it easier to use both plugins together.
-- @link https://github.com/mason-org/mason-lspconfig.nvim
return {
  'mason-org/mason-lspconfig.nvim',
  config = function()
    require('mason-lspconfig').setup({
      ensure_installed = {}, -- explicitly set to an empty table (Installs via mason-tool-installer)
    })
  end,
}
