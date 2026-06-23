---@type vim.lsp.Config
return {
  cmd = { 'css-variables-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'sass', 'less' },
  settings = {
    cssVariables = {
      -- Glob the whole project for custom-property declarations.
      lookupFiles = { '**/*.css', '**/*.scss', '**/*.sass', '**/*.less' },
      blacklistFolders = {
        '**/.cache',
        '**/.git',
        '**/.next',
        '**/.svelte-kit',
        '**/build',
        '**/dist',
        '**/node_modules',
        '**/vendor',
      },
    },
  },
}
