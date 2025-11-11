-- tiny-inline-diagnostic.nvim
-- Inline diagnostic messages with customizable styles and icons.
-- @link https://github.com/rachartier/tiny-inline-diagnostic.nvim
return {
  'rachartier/tiny-inline-diagnostic.nvim',

  event = 'VeryLazy',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup({
      preset = 'powerline',
    })
    vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
  end,
}
