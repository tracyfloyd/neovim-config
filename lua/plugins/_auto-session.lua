-- AutoSession
-- Automatically reopen the files and windows you had open.
-- @link https://github.com/rmagatti/auto-session

return {
  'rmagatti/auto-session',
  enabled = false,

  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  config = function()
    require('auto-session').setup({
      suppressed_dirs = { '~/', '~/Downloads', '~/Documents', '~/Desktop/' },
      -- log_level = 'debug',
    })
  end,
}
