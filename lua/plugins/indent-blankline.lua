-- Indent Blankline
-- Add indentation guides even on blank lines
-- @link https://github.com/lukas-reineke/indent-blankline.nvim

return {
  'lukas-reineke/indent-blankline.nvim',
  enabled = true,

  main = 'ibl',

  config = function()
    require('ibl').setup({
      scope = {
        show_start = false,
      },
    })
  end,
}
