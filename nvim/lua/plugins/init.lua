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
          "javascript",
          "jsdoc",
          "json",
          "typescript",
          "java",
          "javadoc",
          "bash",
          "fish",
          "regex",
          "sql",
          -- "ssh_config",
          "tmux",
          "toml",
          "udev",
          "yaml",
        },
        highlight = { enable = true },
      }
    end,
  },
  {
    "williambosman/mason.nvim",
    opts = {
      ensure_installed = {
        "ts_ls",
        "codelldb",
      },
    },
  },
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

  {
    "patrickpichler/hovercraft.nvim",

    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },

    opts = function()
      return {
        providers = {
          providers = {
            {
              "LSP",
              require("hovercraft.provider.lsp.hover").new(),
            },
            {
              "Man",
              require("hovercraft.provider.man").new(),
            },
            {
              "Dictionary",
              require("hovercraft.provider.dictionary").new(),
            },
          },
        },

        window = {
          border = "single",

          -- enable this if you are a user of the MeanderingProgrammer/render-markdown.nvim plugin
          -- render_markdown_compat_mode = true,
        },

        keys = {
          {
            "<C-u>",
            function()
              require("hovercraft").scroll { delta = -4 }
            end,
          },
          {
            "<C-d>",
            function()
              require("hovercraft").scroll { delta = 4 }
            end,
          },
          {
            "<TAB>",
            function()
              require("hovercraft").hover_next()
            end,
          },
          {
            "<S-TAB>",
            function()
              require("hovercraft").hover_next { step = -1 }
            end,
          },
        },
      }
    end,

    keys = {
      {
        "K",
        function()
          local hovercraft = require "hovercraft"

          if hovercraft.is_visible() then
            hovercraft.enter_popup()
          else
            hovercraft.hover()
          end
        end,
      },
    },
  },

  {
    "lambdalisue/vim-suda",
    lazy = false,
    config = function()
      vim.g.suda_smart_edit = 1
    end,
  },
}

table.insert(M, require "plugins.rust_plugins")
table.insert(M, require "plugins.java_plugins")
table.insert(M, require "plugins.dap_plugins")
table.insert(M, require "plugins.snacks")
table.insert(M, require "plugins.frontend_plugins")

return M
