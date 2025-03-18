local M = {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "vim",
          "lua",
          "vimdoc",
          "html",
          "css",
          "markdown",
          "rust",
          "python",
          "vue",
          "svelte",
        },
        highlight = { enable = true },
      }
    end,
  },
  -- {
  --   "williambosman/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "ts_ls",
  --     },
  --   },
  -- },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    config = function()
      require("todo-comments").setup()
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "pteroctopus/faster.nvim",
    lazy = false,
    config = function()
      require("faster").setup()
    end,
  },
}

table.insert(M, require "plugins.rust_plugins")
table.insert(M, require "plugins.dap_plugins")
table.insert(M, require "plugins.snacks")
table.insert(M, require "plugins.frontend_plugins")

return M
