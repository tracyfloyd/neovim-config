return {

	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			dim_inactive = {
				enabled = true, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.05, -- percentage of the shade to apply to the inactive window
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,

	--[[
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "rose-pine"
  end
  ]]
	--

	--[[
  "folke/tokyonight.nvim",
  name = "tokyonight",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night"
  }
  ]]
	--
}
