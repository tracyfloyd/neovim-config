-- mason-tool-installer
-- @link https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  config = function()
    require('mason-tool-installer').setup({
      ensure_installed = {
        'cssls',
        -- 'emmet_language_server',
        'eslint_d',
        'graphql',
        'html',
        'lua_ls',
        'prettier',
        'roslyn',
        'stylua',
        'svelte',
        'ts_ls',
      },
    })
  end,
}
