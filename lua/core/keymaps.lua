-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to file listing" }) -- Disabled due to Oil.nvim
vim.keymap.set('n', '-', '<cmd>Oil --float<CR>', { desc = "Oil - Open current file's parent directory" })

-- Center screen when jumping
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

-- ======================================================================================
-- Line Management

-- Move selected lines up/down
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
--
-- Yank to end of line
vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank to end of line' })

-- Stay in Normal mode after creating a new line above or below the current one
vim.keymap.set('n', 'O', 'O<Esc>', { desc = 'Append empty line' })
vim.keymap.set('n', 'o', 'o<Esc>', { desc = 'Prepend empty line' })
--
-- Maintain selection when indenting in Visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- ======================================================================================
-- Buffers & Files

vim.keymap.set('n', '<leader>bo', ':%bd|e#|bd#<CR>', { desc = 'Close all buffers except current' })
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })

-- Copy current file's absolute path to clipboard
vim.keymap.set('n', '<leader>pa', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  print('file:', path)
end, { desc = 'Copy absolute filepath of current buffer to clipboard' })

-- Copy current file's relative path to clipboard
vim.keymap.set('n', '<leader>pr', function()
  local path = vim.fn.expand('%')
  vim.fn.setreg('+', path)
  print('Relative path: ' .. path)
end, { desc = 'Copy relative filepath of current buffer to clipboard' })

-- Rename current file
vim.keymap.set('n', '<leader>rr', function()
  local old_name = vim.fn.expand('%')
  local new_name = vim.fn.input('New file name: ', old_name)
  if new_name ~= '' and new_name ~= old_name then
    vim.cmd('saveas ' .. new_name)
    vim.fn.delete(old_name)
    print('File renamed to: ' .. new_name)
  end
end, { desc = 'Rename current file' })

-- ======================================================================================
-- Windows & Splits

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Splitting & Resizing
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = 'Split window horizontally' })
-- vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
-- vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
-- vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
-- vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

-- ======================================================================================
-- Misc

-- Don't copy when deleting
vim.keymap.set({ 'n', 'v' }, 'x', '"_x', { desc = 'Delete selection without copying' })
vim.keymap.set({ 'n', 'v' }, 'X', '"_X', { desc = 'Delete line without copying' })

-- ======================================================================================
-- Ideas to explore

-- Move by the lines on the screen, not arbitrary lines of the document.
-- This can become an issue when line wrapping is enabled.
-- map({ 'n', 'v' }, '<Up>', 'gk', { desc = 'Move up a screenline' })
-- map({ 'n', 'v' }, '<Down>', 'gj', { desc = 'Move down a screenline' })
-- map('i', '<Up>', '<C-o>gk', { desc = 'Move up a screenline' })
-- map('i', '<Down>', '<C-o>gj', { desc = 'Move down a screenline' })
