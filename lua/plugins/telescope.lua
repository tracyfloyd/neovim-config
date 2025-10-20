return {

  -- Telescope (Fuzzy file search)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    tag = '0.1.8',
    config = function()
      require('telescope').setup({})
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("grep > ") });
      end)

    --[[
      vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
      vim.keymap.set("n", "<leader>fr", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", ":Telescope find_files hidden=true <CR>")

        vim.keymap.set('n', '<leader>pws', function()
        local word = vim.fn.expand("<cword>")
        builtin.grep_string({ search = word })
      end)
      vim.keymap.set('n', '<leader>pWs', function()
        local word = vim.fn.expand("<cWORD>")
        builtin.grep_string({ search = word })
      end)
    ]]

    end
  },

}
