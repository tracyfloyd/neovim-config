-- Undotree
-- Undo history vislualizer
-- @link https://github.com/mbbill/undotree

return {
  'mbbill/undotree',
  keys = {
    { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Undotree toggle' },
  },
}
