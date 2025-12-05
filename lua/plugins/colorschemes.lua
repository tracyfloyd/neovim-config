-- colorschemes
--
-- Color schemes for Neovim.
--
-- Lazy loading: The colorscheme is not lazy loaded and has priority 1000 set
--               so it can be available right after start. This is suggested
--               in the lazy.nvim readme.

return {

  'catppuccin/nvim', -- https://github.com/catppuccin/nvim
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.25, -- percentage of the shade to apply to the inactive window
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        grug_far = true,
        harpoon = true,
        indent_blankline = {
          enabled = true,
          scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        mason = true,
        nvim_surround = true,
        nvimtree = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        render_markdown = true,
        telescope = {
          enabled = true,
        },
        which_key = true,
      },
    })
    vim.cmd.colorscheme('catppuccin')
  end,

  --[[
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "rose-pine"
  end
  ]]
  --

  --[[
  "folke/tokyonight.nvim",
  name = "tokyonight",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night"
  }
  ]]
  --
}
