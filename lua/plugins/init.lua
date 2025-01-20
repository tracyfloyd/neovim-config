return {

  -- Fugitive (GIT tools)
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
    end
  },

  -- Indent Blankline (Indentation guides)
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup()
    end
  },

  -- Lualine (Fancy status bar)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      icons_enabled = false,
      theme = 'gruvbox-material',
      component_separators = '|',
      section_separators = '',
    }
  },

  -- Undotree (Undo history vislualizer)
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },

  "nvim-lua/plenary.nvim",
  "theprimeagen/vim-be-good",

}
