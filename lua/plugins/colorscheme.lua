return {

  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
    }
    vim.cmd.colorscheme "catppuccin"
  end

  --[[
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "rose-pine"
  end
  ]]--

  --[[
  "folke/tokyonight.nvim",
  name = "tokyonight",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night"
  }
  ]]--

}
