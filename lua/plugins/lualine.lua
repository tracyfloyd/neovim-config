-- lualine.nvim
-- Show a customizable status line.
-- @link https://github.com/nvim-lualine/lualine.nvim

-- Get the current mode
-- This function gets the current mode identifier and returns it
-- without any changes. Only the special characters are sanitized.
-- @return string the mode
local get_mode = function()
  local mode = vim.api.nvim_get_mode()['mode']
  mode = mode:gsub('\22', '^V')
  mode = mode:gsub('\19', '^S')
  return ' ' .. string.format('%-3s', string.upper(mode))
end

-- Function to get the current mode indicator as a single character
local function mode()
  -- Map of modes to their respective shorthand indicators
  local mode_map = {
    n = 'N', -- Normal mode
    i = 'I', -- Insert mode
    v = 'V', -- Visual mode
    [''] = 'V', -- Visual block mode
    V = 'V', -- Visual line mode
    c = 'C', -- Command-line mode
    no = 'N', -- NInsert mode
    s = 'S', -- Select mode
    S = 'S', -- Select line mode
    ic = 'I', -- Insert mode (completion)
    R = 'R', -- Replace mode
    Rv = 'R', -- Virtual Replace mode
    cv = 'C', -- Command-line mode
    ce = 'C', -- Ex mode
    r = 'R', -- Prompt mode
    rm = 'M', -- More mode
    ['r?'] = '?', -- Confirm mode
    ['!'] = '!', -- Shell mode
    t = 'T', -- Terminal mode
  }
  -- Return the mode shorthand or [UNKNOWN] if no match
  return mode_map[vim.fn.mode()] or '[UNKNOWN]'
end

local colors = {
  blue = '#80a0ff',
  cyan = '#79dac8',
  black = '#080808',
  white = '#c6c6c6',
  red = '#ff5189',
  violet = '#d183e8',
  grey = '#303030',
  dark_grey = '#0f0f19',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.dark_grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

-- Set up lualine.nvim
return {
  'nvim-lualine/lualine.nvim',

  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      theme = bubbles_theme,
      component_separators = '|',
      -- section_separators = '',
      section_separators = { left = '', right = '' },
      icons_enabled = true,
    },
    -- sections = {
    --   -- Left Side
    --   lualine_a = { get_mode },
    --   lualine_b = { 'branch', 'diff', 'diagnostics' },
    --   lualine_c = { { 'filename', path = 1 } },
    --
    --   -- Right Side
    --   lualine_x = { 'encoding', 'fileformat', 'filetype' },
    --   lualine_y = { 'progress' },
    --   lualine_z = { 'location' },
    -- },

    sections = {
      lualine_a = { { mode, separator = { left = '' }, right_padding = 2 } },
      lualine_b = { 'filename', 'branch' },
      lualine_c = {
        '%=', --[[ add your center components here in place of this comment ]]
      },
      lualine_x = {},
      lualine_y = { 'filetype', 'progress' },
      lualine_z = {
        { 'location', separator = { right = '' }, left_padding = 2 },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  },
}
