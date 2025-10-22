return {
	"stevearc/conform.nvim",

	-- optional = true,
	opts = {
		-- formatters by filetype
		formatters_by_ft = {
			lua = { "stylua" },
			php = { "pint", "php_cs_fixer" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
