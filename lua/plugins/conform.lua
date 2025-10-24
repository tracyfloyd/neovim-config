return {
    -- Conform (Code formatter)
    -- https://github.com/stevearc/conform.nvim
    "stevearc/conform.nvim",

    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>cf",
            function()
                require("conform").format({ async = false })
            end,
            mode = "",
            desc = "Conform: Format buffer",
        },
    },

    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- formatters by filetype
        formatters_by_ft = {
            lua = { "stylua" },
            php = { "pint", "php_cs_fixer", stop_after_first = true },
            javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        --format_on_save = {
        --  -- These options will be passed to conform.format()
        --  timeout_ms = 1000,
        --  lsp_format = "fallback",
        --},
    },
}
