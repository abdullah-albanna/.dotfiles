local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    vue = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    svelte = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    -- timeout_ms = 2500,
    lsp_format = "fallback",
    lsp_fallback = true,
  },
}

return options
