-- Runs when an LSP attaches to a buffer.
-- When a file is opened that is associated withan LSP, this function
-- will be executed to configure the current buffer.

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- set keybinds
    opts.desc = 'Show LSP references'
    vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

    opts.desc = 'Go to declaration'
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    opts.desc = 'Show LSP definition'
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    opts.desc = 'Show LSP implementations'
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

    opts.desc = 'Show LSP type definitions'
    vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

    opts.desc = 'See available code actions'
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- in visual mode will apply to selection

    opts.desc = 'Smart rename'
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    opts.desc = 'Show buffer diagnostics'
    vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

    opts.desc = 'Show line diagnostics'
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

    opts.desc = 'Go to previous diagnostic'
    vim.keymap.set('n', '[d', function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts) -- jump to previous diagnostic in buffer

    opts.desc = 'Go to next diagnostic'
    vim.keymap.set('n', ']d', function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts) -- jump to next diagnostic in buffer

    opts.desc = 'Show documentation for what is under cursor'
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = 'Restart LSP'
    vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary
  end,
})

-- vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = '󰠠 ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
})
