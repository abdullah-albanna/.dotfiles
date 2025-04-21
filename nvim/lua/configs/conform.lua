local options = {
  async = true,
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
    python = { "ruff", "isort" },
  },

  format_after_save = {
    async = true,
    lsp_format = "fallback",
    lsp_fallback = true,
  },
}

return options
