---@type vim.lsp.Config
return {
  cmd = { 'svelteserver', '--stdio' },
  filetypes = {
    'svelte',
    'typescript',
    'javascript',
    'html',
    'css',
  },
}
