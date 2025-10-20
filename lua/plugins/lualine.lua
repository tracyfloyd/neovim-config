return {
	-- Lualine (Fancy status bar)
	"nvim-lualine/lualine.nvim",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		icons_enabled = false,
		theme = "gruvbox-material",
		component_separators = "|",
		section_separators = "",
	},
}
