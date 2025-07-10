vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

--  TODO: bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { 0 }, { 0 })
vim.wo.relativenumber = true
vim.opt.smartindent = true -- Smart indentation for new lines

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- local function sanitize_filename(fname)
--   if not fname then
--     return ""
--   end
--   -- Remove suda:// prefix if present
--   if vim.startswith(fname, "suda://") then
--     return fname:sub(#"suda://" + 1)
--   end
--   return fname
-- end
--
-- -- Global table to track files currently handled to prevent recursion
-- local suda_processing = {}
--
-- vim.api.nvim_create_autocmd("BufReadCmd", {
--   callback = function(args)
--     local filename = args.file
--     local bufnr = args.buf
--
--     -- Normalize filename to absolute path
--     filename = vim.fn.fnamemodify(filename or "", ":p")
--
--     if filename == "" then
--       return
--     end
--
--     filename = sanitize_filename(filename)
--
--     if suda_processing[filename] then
--       return
--     end
--
--     if vim.fn.filewritable(filename) ~= 0 then
--       vim.cmd("edit " .. vim.fn.fnameescape(filename))
--       return
--     end
--
--     suda_processing[filename] = true
--
--     vim.defer_fn(function()
--       local orig_buf = bufnr
--
--       vim.cmd("silent! SudaRead " .. vim.fn.fnameescape(filename))
--
--       -- Get new buffer (should be current buffer)
--       local new_buf = vim.api.nvim_get_current_buf()
--
--       -- Close original buffer if different and loaded
--       if orig_buf and orig_buf ~= new_buf and vim.api.nvim_buf_is_loaded(orig_buf) then
--         vim.schedule(function()
--           vim.api.nvim_buf_delete(orig_buf, { force = true })
--           print "🔐 File reopened with sudo via SudaRead, original buffer closed"
--         end)
--       end
--
--       -- Clear recursion flag after short delay to avoid immediate retrigger
--       vim.defer_fn(function()
--         suda_processing[filename] = nil
--       end, 1000)
--     end, 10)
--   end,
-- })

-- -- Enable text wrapping
-- vim.opt.wrap = true
--
-- -- Wrap lines at word boundaries (instead of cutting words in half)
-- vim.opt.linebreak = true
--
-- -- Optional: Add a visual indicator for wrapped lines
-- vim.opt.showbreak = "↪ "
--
