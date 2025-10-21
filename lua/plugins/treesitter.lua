return {
	{
		-- Treesitter (Syntax highlighting)
		"nvim-treesitter/nvim-treesitter",

		lazy = false,
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"blade",
					"css",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"php",
					"php_only",
					"regex",
					"scss",
					"tsx",
					"typescript",
					"yaml",
				},
				highlight = {
					enable = true,
					additional_vim_regex_hihghlighting = false,
				},
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
			})

			--[[
      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      require("nvim-treesitter").setup()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }
      ]]
		end, -- end config
	},
}
