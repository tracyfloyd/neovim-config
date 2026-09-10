-- Twilight
-- Dims inactive portions of the code you're editing.
-- @link https://github.com/folke/twilight.nvim

return {
  'folke/twilight.nvim',
  enabled = true,

  keys = {
    {
      '<leader>tt',
      function()
        -- twilight gates its treesitter path on `pcall(vim.treesitter.get_parser, buf)`
        -- (view.lua:167), but since nvim 0.11 get_parser returns nil instead of
        -- raising when the buffer has no parser -- so the pcall succeeds, and
        -- view.lua:102 then indexes that nil and throws E5108. Decide per buffer
        -- here instead. Dimming still works without treesitter, just line-based.
        local ok, cfg = pcall(require, 'twilight.config')
        if ok and cfg.options then
          cfg.options.treesitter = vim.treesitter.get_parser(0, nil, { error = false }) ~= nil
        end
        vim.cmd('Twilight')
      end,
      desc = 'Toggle Twilight',
    },
  },

  config = function()
    require('twilight').setup({
      dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { 'Normal', '#ffffff' },
        term_bg = '#000000', -- if guibg=NONE, this will be used to calculate text color
        inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      },
      context = 10, -- amount of lines we will try to show around the current line
      treesitter = true, -- use treesitter when available for the filetype
      -- treesitter is used to automatically expand the visible text,
      -- but you can further control the types of nodes that should always be fully expanded
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        'function',
        'method',
        'table',
        'if_statement',
      },
      exclude = {}, -- exclude these filetypes
    })
  end,
}
