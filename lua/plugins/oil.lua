-- Oil (Manage files like text)

return {
  "stevearc/oil.nvim",

  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = true,
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
    },
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  lazy = false, -- Do not lazy load this plugin
}
