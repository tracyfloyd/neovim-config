-- Treesitter Text Objects
-- Syntax aware text-objects, select, move, swap, and peek support
-- @link https://github.com/nvim-treesitter/nvim-treesitter-textobjects

return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  enabled = true,

  branch = 'main',

  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true
  end,

  config = function()
    require("nvim-treesitter-textobjects").setup {
      select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = true,

        keymaps = {
          -- Function
          ['if'] = { query = '@function.inner', desc = 'Select inner part of a function definition' },
          ['af'] = { query = '@function.outer', desc = 'Select outer part of a function definition' },
          -- Parameter/Argument
          ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },
          ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/argument' },
          -- Loop
          ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },
          ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop' },
          -- Class
          ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class' },
          ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class' },
          -- Conditional
          ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },
          ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
          -- Assignment
          ['i='] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
          ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
          ['l='] = { query = '@assignment.lhs', desc = 'Select left hand side of an assignment' },
          ['r='] = { query = '@assignment.rhs', desc = 'Select right hand side of an assignment' },

          -- You can also use captures from other query groups like `locals.scm`
          ['as'] = { query = '@local.scope', query_group = 'locals', desc = 'Select language scope' },
        },

        swap = {
          enable = true,
          swap_next = {
            ['<leader>na'] = '@parameter.inner', -- swap parameters/argument with next
            ['<leader>nf'] = '@function.outer', -- swap function with next
          },
          swap_previous = {
            ['<leader>pa'] = '@parameter.inner', -- swap parameters/argument with prev
            ['<leader>pf'] = '@function.outer', -- swap function with previous
          },
        },

        move = {
          enable = true,
          set_jumps = true,
          --[[  Moves from Josean to explore (via https://www.youtube.com/watch?v=CEMPq_r8UYQ)
          goto_next_start = {
            ["]f"] = { query = "@call.outer", desc = "Next function call start" },
            ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },

          goto_next_end = {
            ["]F"] = { query = "@call.outer", desc = "Next function call end" },
            ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
          },

          goto_previous_start = {
            ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
            ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
            ["[c"] = { query = "@class.outer", desc = "Prev class start" },
            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
          },

          goto_previous_end = {
            ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
            ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
            ["[C"] = { query = "@class.outer", desc = "Prev class end" },
            ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
          },
          --]]

          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = { query = '@class.outer', desc = 'Next class start' },
            --
            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
            [']o'] = '@loop.*',
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            --
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            [']s'] = { query = '@local.scope', query_group = 'locals', desc = 'Next scope' },
            [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
          },

          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },

          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },

          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },

          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          goto_next = {
            [']d'] = '@conditional.outer',
          },

          goto_previous = {
            ['[d'] = '@conditional.outer',
          },
        },
      }
    }
  end,
}
