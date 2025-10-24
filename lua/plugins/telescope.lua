return {
	{
		"nvim-telescope/telescope.nvim",

		dependencies = {

			tag = "0.1.8",
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},

		keys = {
			{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Telescope - Buffer search" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope - Buffers" },
			{ "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "Telescope - Commits" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope - Find All Files" },
			{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Telescope - Git files" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope - Help" },
			{ "<leader>fj", "<cmd>Telescope command_history<cr>", desc = "Telescope - History" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Telescope - Keymaps" },
			{ "<leader>fl", "<cmd>Telescope lsp_references<cr>", desc = "Telescope - Lsp References" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Telescope - Old files" },
			{ "<leader>fr", "<cmd>Telescope live_grep<cr>", desc = "Telescope - Ripgrep" },
			{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Telescope - Grep String" },
			{ "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "Telescope - Treesitter" },
		},

		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				pickers = {
					buffers = {
						mappings = {
							i = {
								-- Remove an item from the buffer list
								["<C-d>"] = actions.delete_buffer + actions.move_to_top,
							},
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>ps", function()
				require("telescope.builtin").grep_string({ search = vim.fn.input("grep > ") })
			end, { desc = "Open grep search command line" })

			vim.keymap.set("n", "<leader>fnv", function()
				require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "Telescope - Find in Neovim config" })
		end,
	},
}
