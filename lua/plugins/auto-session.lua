-- AutoSession
-- Automatically reopen the files and windows you had open. It's like you never left!
-- @link https://github.com/rmagatti/auto-session
return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Downloads', '~/Documents', '~/Desktop/' },
    -- log_level = 'debug',
  },
}
