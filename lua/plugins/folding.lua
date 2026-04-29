-- Origami
-- Use the LSP to provide folds, with Treesitter as fallback if the LSP does not provide folding information.
-- (And indent-based folding if neither is available.)
-- @link https://github.com/chrisgrieser/nvim-origami?tab=readme-ov-file#installation
return {
  'chrisgrieser/nvim-origami',
  event = 'VeryLazy',
  opts = {
    autoFold = {
      enabled = false,
    },
  },
  -- recommended: disable vim's auto-folding
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
}
