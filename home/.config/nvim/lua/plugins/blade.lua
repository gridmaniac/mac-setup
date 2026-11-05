return {
  -- Blade syntax highlighting via Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "blade" })
    end,
  },

  -- Make phpactor also attach to .blade.php files
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        phpactor = {
          filetypes = { "php", "blade" },
        },
      },
    },
  },

  -- blade-formatter for manual formatting only (<leader>cf); no format on save,
  -- the project has no blade formatter config and it rewrites whole files
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "blade",
        callback = function()
          vim.b.autoformat = false
        end,
      })
    end,
  },
}
