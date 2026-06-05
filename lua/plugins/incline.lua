-- Incline
-- Lightweight floating statuslines
-- @link https://github.com/b0o/incline.nvim

return {
  'b0o/incline.nvim',
  enabled = true,

  event = 'VeryLazy',

  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    require('incline').setup({
      window = {
        zindex = 25, -- Lower this to sit behind other floating windows
        margin = { horizontal = 0, vertical = 0 },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        if filename == '' then
          filename = '[No Name]'
        end
        local ft_icon, ft_color = require('nvim-web-devicons').get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        local fg = props.focused and '#cdd6f4' or '#6c7086'
        local icon_bg = props.focused and ft_color or '#45475a'
        local icon_fg = props.focused and '#1c1c19' or '#6c7086'
        return {
          ft_icon and { ' ', ft_icon, ' ', guibg = icon_bg, guifg = icon_fg } or '',
          ' ',
          { filename, guifg = fg, gui = modified and 'bold,italic' or 'bold' },
          modified and { ' ●', guifg = '#d6991d' } or '',
          ' ',
          guibg = '#181825',
        }
      end,
    })
  end,
}
