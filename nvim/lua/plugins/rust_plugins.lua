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
      local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension"
      local codelldb_path = extension_path .. "/adapter/codelldb"
      local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

      local cfg = require "rustaceanvim.config"
      local dap = require "dap"
      local launchjs = require "dap.ext.vscode"

      -- Set up DAP adapter
      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }

      -- Check for .vscode/launch.json
      local launch_json_path = vim.fn.getcwd() .. "/.vscode/launch.json"
      if vim.fn.filereadable(launch_json_path) == 1 then
        launchjs.load_launchjs(launch_json_path, {
          codelldb = { "rust" },
        })
      else
        -- Fallback configuration
        dap.configurations.rust = {
          {
            name = "Rust: debug default binary",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            runInTerminal = false,
          },
        }
      end
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
