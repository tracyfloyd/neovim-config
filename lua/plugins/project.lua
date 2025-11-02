
-- @link https://github.com/ahmedkhalf/project.nvim

return {
  "ahmedkhalf/project.nvim",
  init = function()
    require("project_nvim").setup {
      patterns = { "wp-config.php", ".git", "composer.json", "package.json" },
    }
    require('telescope').load_extension('projects')
    --require('telescope').extensions.projects.projects{}
  end
}
