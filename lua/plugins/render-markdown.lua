return {
  'MeanderingProgrammer/render-markdown.nvim',
  enabled = true,

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },

  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  config = function()
    require('render-markdown').setup({
      html = { enabled = false },
      latex = { enabled = false },
      yaml = { enabled = false },
      completions = {
        blink = { enabled = true },
        lsp = { enabled = true },
      },
    })
  end,
}
