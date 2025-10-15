-- Make Pint the default formatter, and fall back to PHP-CS-Fixer if not found.
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { { "pint", "php_cs_fixer" } },
      },
    },
  },
}
