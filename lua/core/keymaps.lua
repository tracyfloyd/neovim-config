-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to file listing" }) -- Disabled due to Oil.nvim

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

vim.keymap.set('n', '<leader>cf', function()
  require('conform').format({
    lsp_format = 'fallback',
  })
end, { desc = 'Conform - Format current file' })

vim.keymap.set('n', '-', '<cmd>Oil --float<CR>', { desc = "Oil - Open current file's parent directory" })

vim.keymap.set('n', 'gl', function()
  vim.diagnostic.open_float()
end, { desc = 'Open Diagnostics in Float' })

vim.keymap.set('n', '<Leader>cp', ':let @+=expand("%:p")<CR>', { desc = 'Copy filepath of current buffer to clipboard', noremap = true, silent = true })
