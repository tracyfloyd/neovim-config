-- Setup lazy.nvim Package Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")

-- Setup lazy.nvim
require("lazy").setup({
	"nvim-lua/plenary.nvim",
	spec = {
		{ import = "plugins" },
	},
	-- change_detection = { notify = false }
})

require("config.keymaps")

require("config.lualine-bubbles")



-- Autocommands
-- See `:help lua-guide-autocommands`

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Trim trailiong whitespace on save",
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




-- Setup the LSP

-- Add noselect to completeopt, otherwise autocompletion is annoying
vim.cmd("set completeopt+=noselect")

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
