vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Trim trailing whitespace on save",
	pattern = "*",
	command = ":%s/\\s\\+$//e",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	--  Try it with `yap` in normal mode
	--  See `:help vim.highlight.on_yank()`
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Setup LSP completion - I think?",
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
