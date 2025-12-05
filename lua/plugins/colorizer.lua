-- colorizer.lua
--
-- A high-performance color highlighter
--
-- @link https://github.com/NvChad/nvim-colorizer.lua

return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  filetypes = { '*' },
  opts = {
    filetypes = { '*' },
    user_default_options = {
      names = false,
      css = true,
      css_fn = true,
      mode = 'background', -- 'background'|'foreground'|'virtualtext'
      sass = {
        enable = true,
        parsers = {
          'css',
        },
      },
    },
  },
}
