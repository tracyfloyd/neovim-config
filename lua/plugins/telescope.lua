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
          -- find_files = {
          --   theme = 'ivy',
          -- },
          -- help_tags = {
          --   theme = 'ivy',
          -- },
          -- Set keymaps when interactive with picker list of buffers
          buffers = {
            mappings = {
              i = {                                                      -- Insert mode
                ['<C-d>'] = actions.delete_buffer + actions.move_to_top, -- Remove an item from the buffer list
                ['<C-k>'] = actions.move_selection_previous,             -- Move to previous result
                ['<C-j>'] = actions.move_selection_next,                 -- Move to next result
                ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
              },
            },
          },
        },
        extensions = {
          fzf = {},
        },
      })

      telescope.load_extension('fzf')

      -- Keymaps to find files ==========================================================
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {
        desc = 'Telescope: Find files (in cwd)',
      })

      -- <leader>fg   Telescope: multigrep text (in cwd),
      require('telescope.multigrep').setup()

      vim.keymap.set('n', '<leader>fs', require('telescope.builtin').live_grep, {
        desc = 'Telescope: grep text (in cwd)',
      })

      vim.keymap.set('n', '<leader>fc', require('telescope.builtin').grep_string, {
        desc = 'Telescope: grep text under cursor (in cwd)',
      })

      vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, {
        desc = 'Telescope: Find files (recent)',
      })

      vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, {
        desc = 'Telescope: Find buffers',
      })

      -- Keymaps to find in current file ================================================
      vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, {
        desc = 'Telescope: Find text (in current buffer)',
      })

      -- vim.keymap.set('n', '<leader>fl', require('telescope.builtin').lsp_references, {
      -- desc = 'Telescope: LSP References'
      -- })
      vim.keymap.set('n', '<leader>fl', require('telescope.builtin').treesitter, {
        desc = 'Telescope: Find function names, variables, etc. (in current buffer)',
      })

      -- Other keymaps ==================================================================
      vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, {
        desc = 'Telescope: Show previous search state',
      })

      vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {
        desc = 'Telescope: Search help',
      })

      vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', {
        desc = 'Telescope: Find todos',
      })

      -- vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, {
      --   desc = 'Telescope: Git files',
      -- })

      vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, {
        desc = 'Telescope: Find Keymaps',
      })

      vim.keymap.set('n', '<leader>fn', function()
        require('telescope.builtin').find_files({
          cwd = vim.fn.stdpath('config'),
        })
      end, {
        desc = 'Telescope: Find in Neovim config',
      })
    end,
  },
}
