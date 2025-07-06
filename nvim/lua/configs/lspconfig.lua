-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "pyright", "tailwindcss", "ts_ls", "vls", "svelte" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.volar.setup {
  filetypes = { "vue" },
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
}

lspconfig.jdtls.setup {
  cmd = { "jdtls" }, -- or your custom launch command
  root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew"),
  settings = {
    java = {
      format = {
        enabled = true,
      },
    },
  },
}
