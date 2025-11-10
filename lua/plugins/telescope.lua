-- Telescope
--
-- @link https://github.com/nvim-telescope/telescope.nvim

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup({
        pickers = {
          buffers = {
            mappings = {
              i = { -- Insert mode
                ['<C-d>'] = actions.delete_buffer + actions.move_to_top, -- Remove an item from the buffer list
                ['<C-k>'] = actions.move_selection_previous, -- Move to previous result
                ['<C-j>'] = actions.move_selection_next, -- Move to next result
                ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
              },
            },
          },
        },
      })

      telescope.load_extension('fzf')

      local opts = {}

      opts.desc = 'Telescope - Fuzzy find files in cwd'
      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)

      opts.desc = 'Telescope - Fuzzy find recent files'
      vim.keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', opts)

      opts.desc = 'Telescope - Show previous search state'
      vim.keymap.set('n', '<leader>fr', '<cmd>Telescope resume<cr>', opts)

      opts.desc = 'Telescope - Find string in cwd'
      vim.keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>', opts)

      opts.desc = 'Telescope - Find string under cursor in cwd'
      vim.keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>', opts)

      opts.desc = 'Telescope - Find todos'
      vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', opts)

      opts.desc = 'Telescope - Document diagnostics'
      vim.keymap.set('n', '<leader>fd', '<cmd>Telescope lsp_document_diagnostics<cr>', opts)

      opts.desc = 'Telescope - Buffer file name search'
      vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope buffers<cr>', opts)

      opts.desc = 'Telescope - Current buffer fuzzy search'
      vim.keymap.set('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', opts)

      opts.desc = 'Telescope - Git files'
      vim.keymap.set('n', '<C-p>', '<cmd>Telescope git_files<cr>', opts)

      opts.desc = 'Telescope - Help'
      vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {})

      opts.desc = 'Telescope - Keymaps'
      vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<cr>', opts)

      opts.desc = 'Telescope - LSP References'
      vim.keymap.set('n', '<leader>fl', '<cmd>Telescope lsp_references<cr>', opts)
      --keymap.set("n", "<leader>ft", "<cmd>Telescope treesitter<cr>", { desc = "Telescope - Treesitter" })

      opts.desc = 'Telescope - Find in Neovim config'
      vim.keymap.set('n', '<leader>fn', function()
        require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
      end, opts)
    end,
  },
}
