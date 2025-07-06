-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  transparency = true,
  theme = "catppuccin",

  -- hl_override = {
  --   Comment = { italic = true },
  --   ["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--   tabufline = {
--     lazyload = false,
--   },
-- }
--

vim.keymap.set("n", "<leader>H", function()
  vim.lsp.buf.hover()
end, { desc = "Test fancy hover" })

return M
