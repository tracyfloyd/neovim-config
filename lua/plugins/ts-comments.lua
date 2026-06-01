-- ts-comments.nvim
-- Tiny plugin to enhance Neovim's native comments
-- @link https://github.com/folke/ts-comments.nvim

return {
    "folke/ts-comments.nvim",
    enabled = true,

    event = "VeryLazy",

    config = function()
      require('ts-comments').setup({})
    end,
}
