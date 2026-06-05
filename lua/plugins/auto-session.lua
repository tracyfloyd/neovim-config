-- AutoSession
-- Automatically reopen the files and windows you had open.
-- @link https://github.com/rmagatti/auto-session

return {
  'rmagatti/auto-session',
  enabled = true,

  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  config = function()
    require('auto-session').setup({
      suppressed_dirs = { '~/', '~/Downloads', '~/Documents', '~/Desktop/' },
      -- Close oil buffers before saving the session — they're URL-backed
      -- (oil://…) and trigger an "Invalid buffer id" error on restore.
      close_filetypes_on_save = { 'checkhealth', 'oil' },
      -- Don't restore the session when launched with a single dir arg
      -- (e.g. `nvim ./`) — that races with oil's directory hijack and
      -- triggers "Invalid buffer id" from oil's deferred rename callback.
      args_allow_single_directory = false,
      -- log_level = 'debug',
    })
  end,
}
