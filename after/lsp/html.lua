---@type vim.lsp.Config
return {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = {
    'htm',
    'html',
    'php',
    'shtml',
    'templ',
  },
}
