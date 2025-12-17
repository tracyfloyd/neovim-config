-- lualine.nvim
--
-- Show a customizable status line.
--
-- @link https://github.com/nvim-lualine/lualine.nvim

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

-- Set up lualine.nvim
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  -- opts = function(_, opts)
  --   opts.sections.lualine_c[4] = { "filename", path = 1 }
  -- end,

  opts = {
    options = {
      theme = 'catppuccin',
      icons_enabled = true,
    },

    sections = {
      -- Left Side
      lualine_a = {
        { mode, separator = { left = '' } },
      },
      lualine_b = {
        { 'branch' },
        { 'diff' },
      },
      lualine_c = {
        { 'filename', path = 4 },
      },

      -- Right Side
      lualine_x = {
        { 'diagnostics' },
      },
      lualine_y = {
        { 'lsp_status' },
      },
      lualine_z = {
        { 'progress' },
        { 'location', padding = { left = 0, right = 1 } },
      },
    },
    -- winbar = {
    --   lualine_a = { 'mode' },
    --   lualine_b = { 'branch', 'diff' },
    --   lualine_c = { 'filename' }, -- Per-split filename in winbar
    -- },
  },
}
