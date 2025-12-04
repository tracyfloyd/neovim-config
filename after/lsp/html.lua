---@type vim.lsp.Config
return {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = {
    'cshtml',
    'htm',
    'html',
    'php',
    'shtml',
    'templ',
  },
}
