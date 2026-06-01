-- nvim-treesitter
--
-- Easy to use interface to tree-sitter for code parsing (used for highlighting
-- and other things).
--
-- Lazy loading: The plugin is loaded on the `BufRead` event to be available
--               as soon as possible when needed.
--
-- @link https://github.com/nvim-treesitter/nvim-treesitter

-- Syntax highlighting

return {
  'nvim-treesitter/nvim-treesitter',
  enabled = false,

  branch = 'main',
  main = 'nvim-treesitter',

  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    local ensureInstalled = {
      'css',
      'html',
      'lua',
      'php',
      'python',
      'scss',
      'typescript',
    }
    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim
      .iter(ensureInstalled)
      :filter(function(parser)
        return not vim.tbl_contains(alreadyInstalled, parser)
      end)
      :totable()

    require('nvim-treesitter').install(parsersToInstall)
  end,
}
