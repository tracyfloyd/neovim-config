-- Oil
-- @link https://github.com/stevearc/oil.nvim
--
-- A file explorer that lets you edit your filesystem like a normal Neovim buffer.

return {
  'stevearc/oil.nvim',

  dependencies = { 'nvim-tree/nvim-web-devicons' },

  lazy = false, -- Do not lazy load this plugin

  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = true,

    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
    -- Additionally, if it is a string that matches "actions.<name>",
    -- it will use the mapping at require("oil.actions").<name>
    -- Set to `false` to remove a keymap
    -- See :help oil-actions for a list of all available actions
    keymaps = {
      ['-'] = { 'actions.parent', mode = 'n' },
      ['_'] = { 'actions.open_cwd', mode = 'n' },
      ['q'] = { 'actions.close', mode = 'n' },
    },

    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
  },
}
