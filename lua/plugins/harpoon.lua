-- Harpoon
-- Quick file switcher
-- @link https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
  'ThePrimeagen/harpoon',
  enabled = true,

  branch = 'harpoon2',

  keys = function()
    local keys = {
      {
        '<leader>H',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Harpoon File',
      },
      {
        '<leader>h',
        function()
          local harpoon = require('harpoon')
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon Quick Menu',
      },
    }

    for i = 1, 9 do
      table.insert(keys, {
        '<leader>' .. i,
        function()
          require('harpoon'):list():select(i)
        end,
        desc = 'Harpoon to File ' .. i,
      })
    end
    return keys
  end,

  config = function()
    require('harpoon').setup({
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    })
  end,
}
