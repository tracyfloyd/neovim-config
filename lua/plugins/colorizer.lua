-- colorizer.lua
--
-- Highlights various color notations.
--
-- Lazy loading: The plugin gets only loaded on certain file types where the
--               color notations are actually used (CSS, Python, Javascript).
--
-- @link https://github.com/NvChad/nvim-colorizer.lua


return {
    'NvChad/nvim-colorizer.lua',
    ft = { 'css', 'scss', 'javascript' },
    opts = {
        filetypes = { '*' },
        user_default_options = {
            names = false,
            mode = 'virtualtext',
            virtualtext = '●',
            RRGGBBAA = true,
            css_fn = true,
        }
    }
}

