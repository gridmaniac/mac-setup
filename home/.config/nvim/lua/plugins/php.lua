-- Override for LazyVim's lang.php extra.
--
-- That extra wires up generic `phpcs` (diagnostics) and `php-cs-fixer` (formatting) for PHP,
-- both running with their own default rulesets. centapp2 doesn't use phpcs at all (no
-- phpcs.xml) and enforces style solely via Laravel Pint (pint.json), checked in the
-- pre-commit hook (.githooks/pre-commit -> make pint-hook) — not live in the editor.
-- Generic phpcs disagrees with Pint's Laravel preset (e.g. concat spacing), producing
-- false-positive diagnostics. This file removes the mismatched sources and wires
-- formatting to the project's own `vendor/bin/pint` instead.

return {
  -- Drop the generic phpcs/php-cs-fixer sources the extra injects into none-ls.
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.sources = vim.tbl_filter(function(source)
        return source.name ~= "phpcs" and source.name ~= "phpcsfixer"
      end, opts.sources or {})
    end,
  },

  -- Stop nvim-lint from running phpcs on php files.
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.php = nil
    end,
  },

  -- Format php with this project's own Pint config instead of generic php-cs-fixer.
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.php = { "pint" }

      opts.formatters = opts.formatters or {}
      opts.formatters.pint = {
        command = "vendor/bin/pint",
        args = { "$FILENAME" },
        stdin = false,
        cwd = require("conform.util").root_file({ "pint.json", "composer.json" }),
      }
    end,
  },

  -- phpcs/php-cs-fixer are no longer used for this project; no need for Mason to manage them.
  {
    "mason-org/mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return tool ~= "phpcs" and tool ~= "php-cs-fixer"
      end, opts.ensure_installed or {})
    end,
  },
}
