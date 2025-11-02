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
          "vim",
          "yaml",
        },

      })

      -- ======================================================================
      -- Configure Laravel blade template support
      local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      parser_configs.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade"
      }
      vim.filetype.add({
        pattern = {
          ['.*%.blade%.php'] = "blade",
        }
      })
      local bladeGrp
      vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
      vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = "*.blade.php",
        group = bladeGrp,
        callback = function()
          vim.opt.filetype = "blade"
        end,
      })
      -- ======================================================================

    end,
  },
}
