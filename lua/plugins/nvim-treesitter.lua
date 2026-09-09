-- nvim-treesitter
-- Syntax highlighting
-- @link https://github.com/nvim-treesitter/nvim-treesitter
--
-- Sole parser/query manager. Parsers land in stdpath('data')/site/parser and
-- queries are symlinked into stdpath('data')/site/queries. Highlighting itself
-- is started by the FileType autocmd in lua/core/autocmds.lua, since the main
-- branch does not enable it for you. Requires the tree-sitter CLI and a C
-- compiler to build parsers.

return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,

  branch = 'main',
  main = 'nvim-treesitter',

  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  config = function()
    require('nvim-treesitter').setup({})
    require('nvim-treesitter').install({
      'blade',
      'c_sharp',
      'comment',
      'css',
      'csv',
      'diff',
      'dockerfile',
      'dtd',
      'editorconfig',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'graphql',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'json5',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'passwd',
      'php',
      'php_only',
      'python',
      'razor',
      'robots_txt',
      'scss',
      'sql',
      'superhtml',
      'svelte',
      'tsv',
      'tsx',
      'typescript',
      'typespec',
      'vim',
      'vimdoc',
      'vue',
      'xml',
      'yaml',
      'zsh',
    })
  end,
}
