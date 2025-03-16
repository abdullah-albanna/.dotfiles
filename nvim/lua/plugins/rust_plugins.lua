local M = {

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = "rust",
    config = function()
      local mason_registry = require "mason-registry"
      local codelldb = mason_registry.get_package "codelldb"
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      local cfg = require "rustaceanvim.config"

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
    ["rust-analyzer"] = {
      cargo = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        buildScripts = {
          enable = true,
        },
        allFeatures = true,
      },
      checkOnSave = {
        enable = false,
        command = "clippy",
      },
      procMacro = {
        enable = true,
      },
      checkOnType = {
        enable = true,
      },
      {
        diagnostics = {
          experimental = true,
        },
      },
    },
  },
}

return M
