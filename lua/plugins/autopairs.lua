-- Autopairs
--
-- A super powerful autopair plugin for Neovim that supports multiple characters.
--
-- @link https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',

  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/nvim-cmp',
  },
  config = function()
    require('nvim-autopairs').setup({
      enable_check_bracket_line = false,
    })

    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
