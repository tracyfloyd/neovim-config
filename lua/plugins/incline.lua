-- incline
--
-- Lightweight floating statuslines
--
-- @link https://github.com/b0o/incline.nvim

return {
  'b0o/incline.nvim',
  -- enabled = false,
  config = function()
    require('incline').setup({
      window = {
        zindex = 25, -- Lower this to sit behind other floating windows
      },
    })
  end,
  -- Optional: Lazy load Incline
  event = 'VeryLazy',
}
