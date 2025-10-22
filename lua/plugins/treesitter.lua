return {
	{
		-- Treesitter (Syntax highlighting)
		"nvim-treesitter/nvim-treesitter",

    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
		lazy = false,

		dependencies = {
		    "nvim-treesitter/nvim-treesitter-textobjects",
		},

		config = function()
			require("nvim-treesitter.configs").setup({
				indent = { enable = true },
				sync_install = false,
				auto_install = true,

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

				highlight = {
					enable = true,
					additional_vim_regex_hihghlighting = false,
				},

				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<Enter>", -- set to `false` to disable one of the mappings
						node_incremental = "<Enter>",
						scope_incremental = false,
						node_decremental = "<Backspace>",
					},
				},

				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						include_surrounding_whitespace = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
						},

						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
					},

					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
						},
						swap_previous = {
							["<leader>A"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
						},
					},

					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
							["]o"] = "@loop.*",
							["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						goto_next = {
							["]d"] = "@conditional.outer",
						},
						goto_previous = {
							["[d"] = "@conditional.outer",
						},
					},
				}
			})

		end,
	},
}
