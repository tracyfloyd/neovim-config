-- @link https://github.com/ahmedkhalf/project.nvim

return {
  'ahmedkhalf/project.nvim',
  init = function()
    require('project_nvim').setup({
      detection_methods = { 'lsp', 'pattern' },
      patterns = { 'wp-config.php', '*.sln', '.git' },
    })
    require('telescope').load_extension('projects')
  end,
}
