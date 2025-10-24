-- which-key.nvim
--
-- Assistant that shows key binds on key presses.
--
-- Lazy loading: The plugin gets loaded with the `VeryLazy` event because it
--               is not critical for the main UI.
--
-- @link https://github.com/folke/which-key.nvim


return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        win = {
            padding = { 1, 1 }
        }
    },
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
