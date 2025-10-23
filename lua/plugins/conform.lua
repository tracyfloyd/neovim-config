return {
	-- Conform (Code formatter)
	-- https://github.com/stevearc/conform.nvim
	"stevearc/conform.nvim",
	-- test
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = false })
			end,
			mode = "",
			desc = "Coform: Format buffer",
		},
	},

	---@module "conform"
	---@type conform.setupOpts
	opts = {
		-- formatters by filetype
		formatters_by_ft = {
			lua = { "stylua" },
			php = { "pint", "php_cs_fixer" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
		},
		--format_on_save = {
		--	-- These options will be passed to conform.format()
		--	timeout_ms = 500,
		--	lsp_format = "fallback",
		--	},
	},
}
