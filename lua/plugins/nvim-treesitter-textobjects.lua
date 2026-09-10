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
    -- The main branch only accepts these keys. Keymaps are no longer declared
    -- in setup() the way the master branch did it -- unknown keys are silently
    -- swallowed -- so they are bound by hand below.
    require('nvim-treesitter-textobjects').setup({
      select = {
        lookahead = true,
        include_surrounding_whitespace = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local select = require('nvim-treesitter-textobjects.select')
    local swap = require('nvim-treesitter-textobjects.swap')
    local move = require('nvim-treesitter-textobjects.move')

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
    end

    -- Select
    -- The last field of each entry is a query group; 'textobjects' reads
    -- textobjects.scm, 'locals' reads locals.scm.
    local selections = {
      -- Function
      { 'if', '@function.inner', 'textobjects', 'Select inner part of a function definition' },
      { 'af', '@function.outer', 'textobjects', 'Select outer part of a function definition' },
      -- Parameter/Argument
      { 'ia', '@parameter.inner', 'textobjects', 'Select inner part of a parameter/argument' },
      { 'aa', '@parameter.outer', 'textobjects', 'Select outer part of a parameter/argument' },
      -- Loop
      { 'il', '@loop.inner', 'textobjects', 'Select inner part of a loop' },
      { 'al', '@loop.outer', 'textobjects', 'Select outer part of a loop' },
      -- Class
      { 'ic', '@class.inner', 'textobjects', 'Select inner part of a class' },
      { 'ac', '@class.outer', 'textobjects', 'Select outer part of a class' },
      -- Conditional
      { 'ii', '@conditional.inner', 'textobjects', 'Select inner part of a conditional' },
      { 'ai', '@conditional.outer', 'textobjects', 'Select outer part of a conditional' },
      -- Assignment
      { 'i=', '@assignment.inner', 'textobjects', 'Select inner part of an assignment' },
      { 'a=', '@assignment.outer', 'textobjects', 'Select outer part of an assignment' },
      { 'l=', '@assignment.lhs', 'textobjects', 'Select left hand side of an assignment' },
      { 'r=', '@assignment.rhs', 'textobjects', 'Select right hand side of an assignment' },
      -- Scope, from the `locals` query group rather than `textobjects`
      { 'as', '@local.scope', 'locals', 'Select language scope' },
    }

    for _, spec in ipairs(selections) do
      local lhs, query, group, desc = unpack(spec)
      map({ 'x', 'o' }, lhs, function()
        select.select_textobject(query, group)
      end, desc)
    end

    -- Swap
    local swaps = {
      { '<leader>na', swap.swap_next, '@parameter.inner', 'Swap parameter/argument with next' },
      { '<leader>nf', swap.swap_next, '@function.outer', 'Swap function with next' },
      -- Capitalised: <leader>pa is taken by "copy absolute filepath" in core/keymaps.lua.
      { '<leader>Pa', swap.swap_previous, '@parameter.inner', 'Swap parameter/argument with previous' },
      { '<leader>Pf', swap.swap_previous, '@function.outer', 'Swap function with previous' },
    }

    for _, spec in ipairs(swaps) do
      local lhs, fn, query, desc = unpack(spec)
      map('n', lhs, function()
        fn(query, 'textobjects')
      end, desc)
    end

    -- Move
    -- Unlike the master branch, query strings are matched literally -- lua
    -- patterns such as '@loop.*' no longer expand, so pass an explicit list.
    local moves = {
      { ']m', move.goto_next_start, '@function.outer', 'textobjects', 'Next function start' },
      { ']]', move.goto_next_start, '@class.outer', 'textobjects', 'Next class start' },
      { ']o', move.goto_next_start, { '@loop.inner', '@loop.outer' }, 'textobjects', 'Next loop start' },
      -- No ]s: that is Vim's next-misspelling motion, and spell is enabled in
      -- markdown/text/gitcommit (core/autocmds.lua). `as` still selects a scope.
      -- ]z shadows Vim's fold motion, which is inert here anyway ('foldenable'
      -- is false in core/options.lua).
      { ']z', move.goto_next_start, '@fold', 'folds', 'Next fold' },
      { ']M', move.goto_next_end, '@function.outer', 'textobjects', 'Next function end' },
      { '][', move.goto_next_end, '@class.outer', 'textobjects', 'Next class end' },
      { '[m', move.goto_previous_start, '@function.outer', 'textobjects', 'Previous function start' },
      { '[[', move.goto_previous_start, '@class.outer', 'textobjects', 'Previous class start' },
      { '[M', move.goto_previous_end, '@function.outer', 'textobjects', 'Previous function end' },
      { '[]', move.goto_previous_end, '@class.outer', 'textobjects', 'Previous class end' },
      -- Go to whichever of start/end is closer. ]d/[d would be shadowed by the
      -- buffer-local diagnostic jumps in core/autocmds.lua, so use ]k/[k.
      { ']k', move.goto_next, '@conditional.outer', 'textobjects', 'Next conditional' },
      { '[k', move.goto_previous, '@conditional.outer', 'textobjects', 'Previous conditional' },
    }

    for _, spec in ipairs(moves) do
      local lhs, fn, query, group, desc = unpack(spec)
      map({ 'n', 'x', 'o' }, lhs, function()
        fn(query, group)
      end, desc)
    end
  end,
}
