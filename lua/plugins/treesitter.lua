-- nvim-treesitter
--
-- Easy to use interface to tree-sitter for code parsing (used for highlighting
-- and other things).
--
-- Lazy loading: The plugin is loaded on the `BufRead` event to be available
--               as soon as possible when needed.
--
-- @link https://github.com/nvim-treesitter/nvim-treesitter

-- Syntax highlighting

return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  -- build = ':TSUpdate',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = {
        languages = {
          php_only = '// %s',
          php = '// %s',
        },
      },
    },
  },
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'blade',
      'comment',
      'c_sharp',
      'css',
      'csv',
      'diff',
      'dockerfile',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'superhtml',
      'http',
      'ini',
      'javascript',
      'jsdoc',
      'json',
      'jsonc',
      'lua',
      'markdown',
      'nginx',
      'php',
      'php_only',
      'phpdoc',
      'razor',
      'regex',
      'scss',
      'sql',
      'tsx',
      'typescript',
      'vim',
      'xml',
      'yaml',
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
      disable = { 'yaml' },
    },
    rainbow = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<Enter>', -- set to `false` to disable one of the mappings
        node_incremental = '<Enter>',
        scope_incremental = false,
        node_decremental = '<Backspace>',
      },
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = true,

        -- Default mode for keymaps is 'v', but this can be changed is needed via section_modes below
        selection_modes = {
          -- ['@parameter.outer'] = 'v', -- charwise
          -- ['@function.outer'] = 'V', -- linewise
          -- ['@class.outer'] = '<c-v>', -- blockwise
        },

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
      },
    },
  },
  config = function(_, opts)
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

    parser_config.blade = {
      install_info = {
        url = 'https://github.com/EmranMR/tree-sitter-blade',
        files = { 'src/parser.c' },
        branch = 'main',
      },
      filetype = 'blade',
    }

    vim.filetype.add({
      pattern = {
        ['.*%.blade%.php'] = 'blade',
        ['.*%.cshtml'] = 'razor',
      },
    })

    require('nvim-treesitter.configs').setup(opts)
  end,
}
