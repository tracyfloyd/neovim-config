-- Add noselect to completeopt, otherwise autocompletion is annoying
vim.cmd("set completeopt+=noselect")

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = ":%s/\\s\\+$//e",
})

-- Configure the LSP
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Capabilities required for the visualstudio lsps (css, html, etc)
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- For all configs
-- vim.lsp.config('*', {
--  root_markers = { '.git' },
--  capabilities = capabilities
-- })

vim.lsp.enable({
	"antlersls",
	"cssls",
	"html",
	"intelephense",
	"jsonls",
	"lua-language-server",
	"typescript-language-server",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

require("config.lazy")
