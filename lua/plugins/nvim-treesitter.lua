-- nvim-treesitter
-- Syntax highlighting
-- @link https://github.com/nvim-treesitter/nvim-treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,

  branch = 'main',
  main = 'nvim-treesitter',

  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  init = function()
    require('nvim-treesitter').setup({})
    require('nvim-treesitter').install({
      'css',
      'html',
      'lua',
      'php',
      'python',
      'scss',
      'typescript',
    })
  end,
}
