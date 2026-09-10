-- Neo Scroll
-- Add smooth scrolling to avoid jarring jumps
-- @link https://github.com/karb94/neoscroll.nvim

return {
  'karb94/neoscroll.nvim',
  enabled = true,

  config = function()
    local neoscroll = require('neoscroll')

    -- mappings = {} stops neoscroll from binding its own defaults, which it
    -- does without descriptions. Every scroll key is defined below instead so
    -- it shows up named in which-key and :Telescope keymaps.
    neoscroll.setup({
      mappings = {},
      -- easing = 'sine',
    })

    local scrolls = {
      {
        '<C-u>',
        'Scroll half page up (smooth)',
        function()
          neoscroll.ctrl_u({ duration = 100 })
        end,
      },
      {
        '<C-d>',
        'Scroll half page down (smooth)',
        function()
          neoscroll.ctrl_d({ duration = 100 })
        end,
      },
      {
        '<C-b>',
        'Scroll page up (smooth)',
        function()
          neoscroll.ctrl_b({ duration = 250 })
        end,
      },
      {
        '<C-f>',
        'Scroll page down (smooth)',
        function()
          neoscroll.ctrl_f({ duration = 250 })
        end,
      },
      {
        '<C-y>',
        'Scroll view up one line (smooth)',
        function()
          neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
        end,
      },
      {
        '<C-e>',
        'Scroll view down one line (smooth)',
        function()
          neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
        end,
      },
      {
        'zt',
        'Cursor line to top (smooth)',
        function()
          neoscroll.zt({ half_win_duration = 250 })
        end,
      },
      {
        'zz',
        'Cursor line to centre (smooth)',
        function()
          neoscroll.zz({ half_win_duration = 250 })
        end,
      },
      {
        'zb',
        'Cursor line to bottom (smooth)',
        function()
          neoscroll.zb({ half_win_duration = 250 })
        end,
      },
    }

    for _, spec in ipairs(scrolls) do
      local lhs, desc, fn = unpack(spec)
      vim.keymap.set({ 'n', 'v', 'x' }, lhs, fn, { desc = desc, silent = true })
    end
  end,
}
