-- Telescope
-- @link https://github.com/nvim-telescope/telescope.nvim

-- telescope-fzf-native ships a Makefile; Windows has no `make` by default,
-- so build it with CMake there instead (requires a C compiler either way).
-- The VS generator defaults to the x64 platform regardless of host, so pass
-- -A explicitly or ARM64 hosts end up with an unloadable x64 DLL.
local fzf_native_build = vim.fn.has('win32') == 1 and ('cmake -S. -Bbuild -A ' .. ({ arm64 = 'ARM64', x86_64 = 'x64' })[vim.uv.os_uname().machine] .. ' -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build') or 'make'

return {
  {
    'nvim-telescope/telescope.nvim',
    enabled = true,
    version = '*',

    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = fzf_native_build },
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
              i = { -- Insert mode
                ['<C-d>'] = actions.delete_buffer + actions.move_to_top, -- Remove an item from the buffer list
                ['<C-k>'] = actions.move_selection_previous, -- Move to previous result
                ['<C-j>'] = actions.move_selection_next, -- Move to next result
                ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
              },
            },
          },
        },
        extensions = {
          fzf = {},
        },
      })

      -- fzf-native is a compiled native module; if it hasn't been built yet
      -- (e.g. no C toolchain installed), skip it instead of erroring on startup.
      local ok, err = pcall(telescope.load_extension, 'fzf')
      if not ok then
        vim.notify('telescope-fzf-native not loaded: ' .. err, vim.log.levels.WARN)
      end

      -- Keymaps to find files ==========================================================
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {
        desc = 'Telescope: Find files (in cwd)',
      })

      vim.keymap.set('n', '<leader>fg', require('telescope.multigrep'), {
        desc = 'Telescope: multigrep (search + glob filter)',
      })

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
