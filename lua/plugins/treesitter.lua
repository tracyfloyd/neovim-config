-- nvim-treesitter
--
-- Easy to use interface to tree-sitter for code parsing (used for highlighting
-- and other things).
--
-- Lazy loading: The plugin is loaded on the `BufRead` event to be available
--               as soon as possible when needed.
--
-- @link https://github.com/nvim-treesitter/nvim-treesitter


return {
  {
    "nvim-treesitter/nvim-treesitter",

    lazy = false,
    build = ":TSUpdate",
    event = { 'BufRead' },

    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true, additional_vim_regex_hihghlighting = false },
        indent = { enable = true },
        sync_install = false,

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Enter>", -- set to `false` to disable one of the mappings
            node_incremental = "<Enter>",
            scope_incremental = false,
            node_decremental = "<Backspace>",
          },
        },

        ensure_installed = {
          "blade",
          "css",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "markdown",
          "markdown_inline",
          "php",
          "php_only",
          "regex",
          "scss",
          "tsx",
          "typescript",
          "yaml",
        },

      })

    end,
  },
}
