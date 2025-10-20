-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to file listing (Disabled due to Oil)" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Disable arrow keys in insert mode with a styled message
--vim.keymap.set('i', '<Up>', "'Use k'<CR>")
--vim.keymap.set('i', '<Down>', "'Use j'<CR>")
--vim.keymap.set('i', '<Left>', "'Use h'<CR>")
--vim.keymap.set('i', '<Right>', "'Use l'<CR>")
-- Disable arrow keys in normal mode with a styled message
--vim.keymap.set('n', '<Up>', ":echoe 'Use k'<CR>")
--vim.keymap.set('n', '<Down>', ":echoe 'Use j'<CR>")
--vim.keymap.set('n', '<Left>', ":echoe 'Use h'<CR>")
--vim.keymap.set('n', '<Right>', ":echoe 'Use l'<CR>")

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Format current file" })

vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory in Oil" })

vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })
