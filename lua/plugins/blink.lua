return {
    {
        "L3MON4D3/LuaSnip", keys = {}
    },

    {
        "saghen/blink.cmp",

        dependencies = {
            "rafamadriz/friendly-snippets",
        },

        version = "*",

        config = function()
            require("blink.cmp").setup({
                snippets = { preset = "luasnip" },
                signature = { enabled = true },
                appearance = {
                    use_nvim_cmp_as_default = false,
                    nerd_font_variant = "normal",
                },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                    providers = {
                        cmdline = {
                            min_keyword_length = 2,
                        },
                    },
                },
                keymap = {
                    ["<C-f>"] = {},
                    ["<Tab>"] = function(fallback)
                      if require("blink.cmp").visible() then
                        require("blink.cmp").select_next_item()
                      elseif require("luasnip").expand_or_jumpable() then
                        require("luasnip").expand_or_jump()
                      else
                        fallback()
                      end
                    end,
                    ["<S-Tab>"] = function(fallback)
                      if require("blink.cmp").visible() then
                        require("blink.cmp").select_prev_item()
                      elseif require("luasnip").jumpable(-1) then
                        require("luasnip").jump(-1)
                      else
                        fallback()
                      end
                    end,
                    -- Add mapping for accepting completion, e.g.:
                    ["<C-y>"] = require("blink.cmp").confirm,
                    -- Or use <CR> (Enter) with caution to avoid unintended newlines:
                    -- ["<CR>"] = require("blink.cmp").confirm,
                },
                cmdline = {
                    enabled = false,
                    completion = { menu = { auto_show = true } },
                    keymap = {
                        ["<CR>"] = { "accept_and_enter", "fallback" },
                    },
                },
                completion = {
                    menu = {
                        border = nil,
                        scrolloff = 1,
                        scrollbar = false,
                        draw = {
                            columns = {
                                { "kind_icon" },
                                { "label",      "label_description", gap = 1 },
                                { "kind" },
                                { "source_name" },
                            },
                        },
                    },
                    documentation = {
                        window = {
                            border = nil,
                            scrollbar = false,
                            winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
                        },
                        auto_show = true,
                        auto_show_delay_ms = 500,
                    },
                },
            })

            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
