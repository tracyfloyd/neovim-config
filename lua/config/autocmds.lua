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
