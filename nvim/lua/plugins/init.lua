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
          "ssh_config",
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

  -- {
  --   "lewis6991/hover.nvim",
  --   config = function()
  --     require("hover").setup {
  --       init = function()
  --         -- Require providers
  --         require "hover.providers.lsp"
  --         require "hover.providers.gh"
  --         require "hover.providers.gh_user"
  --         require "hover.providers.jira"
  --         require "hover.providers.dap"
  --         require "hover.providers.fold_preview"
  --         require "hover.providers.diagnostic"
  --         require "hover.providers.man"
  --         require "hover.providers.dictionary"
  --         require "hover.providers.highlight"
  --       end,
  --       preview_opts = {
  --         border = "rounded",
  --       },
  --       -- Whether the contents of a currently open hover window should be moved
  --       -- to a :h preview-window when pressing the hover keymap.
  --       preview_window = true,
  --       title = true,
  --       mouse_providers = {
  --         "LSP",
  --       },
  --       mouse_delay = 1000,
  --     }
  --   end,
  -- },
  --
  {
    "patrickpichler/hovercraft.nvim",

    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },

    -- this is the default config and can be skipped
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
}

table.insert(M, require "plugins.rust_plugins")
table.insert(M, require "plugins.java_plugins")
table.insert(M, require "plugins.dap_plugins")
table.insert(M, require "plugins.snacks")
table.insert(M, require "plugins.frontend_plugins")

return M
