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

    -- No `version` pin: telescope's newest tag is v0.2.2 (Sept 2024), so '*'
    -- held this two years behind the branch every other plugin tracks.
    cmd = 'Telescope',

    keys = {
      -- Find files
      {
        '<leader>ff',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = 'Telescope: Find files (in cwd)',
      },
      {
        '<leader>fg',
        function()
          require('telescope.multigrep')()
        end,
        desc = 'Telescope: multigrep (search + glob filter)',
      },
      {
        '<leader>fs',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'Telescope: grep text (in cwd)',
      },
      {
        '<leader>fc',
        function()
          require('telescope.builtin').grep_string()
        end,
        desc = 'Telescope: grep text under cursor (in cwd)',
      },
      {
        '<leader>fo',
        function()
          require('telescope.builtin').oldfiles()
        end,
        desc = 'Telescope: Find files (recent)',
      },
      {
        '<leader><leader>',
        function()
          require('telescope.builtin').buffers()
        end,
        desc = 'Telescope: Find buffers',
      },

      -- Find in current file
      {
        '<leader>/',
        function()
          require('telescope.builtin').current_buffer_fuzzy_find()
        end,
        desc = 'Telescope: Find text (in current buffer)',
      },
      {
        '<leader>fl',
        function()
          require('telescope.builtin').treesitter()
        end,
        desc = 'Telescope: Find function names, variables, etc. (in current buffer)',
      },

      -- Other
      {
        '<leader>fr',
        function()
          require('telescope.builtin').resume()
        end,
        desc = 'Telescope: Show previous search state',
      },
      {
        '<leader>fh',
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = 'Telescope: Search help',
      },
      { '<leader>ft', '<cmd>TodoTelescope<cr>', desc = 'Telescope: Find todos' },
      {
        '<leader>fk',
        function()
          require('telescope.builtin').keymaps()
        end,
        desc = 'Telescope: Find Keymaps',
      },
      {
        '<leader>fn',
        function()
          require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
        end,
        desc = 'Telescope: Find in Neovim config',
      },
      -- <leader>fd (buffer diagnostics) is set per-buffer on LspAttach in core/autocmds.lua
    },

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
    end,
  },
}
