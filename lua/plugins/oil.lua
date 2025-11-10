-- Oil
-- A file explorer that lets you edit your filesystem like a normal Neovim buffer.
-- @link https://github.com/stevearc/oil.nvim

return {
  'stevearc/oil.nvim',

  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons

  lazy = false, -- Do not lazy load this plugin

  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = true,
    keymaps = {
      ['q'] = { 'actions.close', mode = 'n' },
    },
    view_options = {
      show_hidden = true,
    },
  },
}
