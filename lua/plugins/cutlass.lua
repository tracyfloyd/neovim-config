-- cutlass.nvim
--
-- Cutlass overrides the delete operations to actually just delete and not affect the current yank.
-- It overrides the following keys to always use the black hole register: c, C, s, S, d, D, x, X.
--
-- @link https://github.com/gbprod/cutlass.nvim

return {
  {
    'gbprod/cutlass.nvim',
    opts = {
      -- your configuration comes here
      -- or don't set opts to use the default settings
      -- refer to the configuration section below
    },
  },
}
