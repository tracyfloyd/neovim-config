-- lualine.nvim
--
-- Show a customizable status line.
--
-- Lazy loading: The plugin gets loaded with the `VeryLazy` event because it
--               is not critical for the main UI.
--
-- @link https://github.com/nvim-lualine/lualine.nvim


-- Get the current mode
--
-- This function gets the current mode identifier and returns it without any
-- changes. Only the special characters are sanitized.
--
-- @return string the mode
local get_mode = function ()
    local mode = vim.api.nvim_get_mode()['mode']
    mode = mode:gsub('\22', '^V')
    mode = mode:gsub('\19', '^S')
    return ' '..string.format('%-3s', string.upper(mode))
end


-- Set up lualine.nvim
return {
    'nvim-lualine/lualine.nvim',

    event = 'VeryLazy',
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        options = {
            component_separators = '|',
            section_separators = '',
            icons_enabled = false,
        },
        sections = {
            -- Left Side
            lualine_a = { get_mode },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { { 'filename', path = 1 } },

            -- Right Side
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }

        }
    }
}
