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

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "build.gradle", "build.gradle.kts" },
  callback = function()
    vim.fn.jobstart({ "gradle", "clean", "eclipse" }, {
      stdout_buffered = true,
      on_exit = function()
        vim.cmd "LspRestart"
        vim.notify("Gradle updated + LSP restarted", vim.log.levels.INFO)
      end,
    })
  end,
})

-- require("render-markdown").setup {
--   completions = { lsp = { enabled = true } },
--   callout = {
--     -- Callouts are a special instance of a 'block_quote' that start with a 'shortcut_link'.
--     -- The key is for healthcheck and to allow users to change its values, value type below.
--     -- | raw        | matched against the raw text of a 'shortcut_link', case insensitive |
--     -- | rendered   | replaces the 'raw' value when rendering                             |
--     -- | highlight  | highlight for the 'rendered' text and quote markers                 |
--     -- | quote_icon | optional override for quote.icon value for individual callout       |
--     -- | category   | optional metadata useful for filtering                              |
--
--     note = {
--       raw = "[!NOTE]",
--       rendered = "󰋽 Note",
--       highlight = "RenderMarkdownInfo",
--       category = "github",
--     },
--     tip = {
--       raw = "[!TIP]",
--       rendered = "󰌶 Tip",
--       highlight = "RenderMarkdownSuccess",
--       category = "github",
--     },
--     important = {
--       raw = "[!IMPORTANT]",
--       rendered = "󰅾 Important",
--       highlight = "RenderMarkdownHint",
--       category = "github",
--     },
--     warning = {
--       raw = "[!WARNING]",
--       rendered = "󰀪 Warning",
--       highlight = "RenderMarkdownWarn",
--       category = "github",
--     },
--     caution = {
--       raw = "[!CAUTION]",
--       rendered = "󰳦 Caution",
--       highlight = "RenderMarkdownError",
--       category = "github",
--     },
--     -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
--     abstract = {
--       raw = "[!ABSTRACT]",
--       rendered = "󰨸 Abstract",
--       highlight = "RenderMarkdownInfo",
--       category = "obsidian",
--     },
--     summary = {
--       raw = "[!SUMMARY]",
--       rendered = "󰨸 Summary",
--       highlight = "RenderMarkdownInfo",
--       category = "obsidian",
--     },
--     tldr = {
--       raw = "[!TLDR]",
--       rendered = "󰨸 Tldr",
--       highlight = "RenderMarkdownInfo",
--       category = "obsidian",
--     },
--     info = {
--       raw = "[!INFO]",
--       rendered = "󰋽 Info",
--       highlight = "RenderMarkdownInfo",
--       category = "obsidian",
--     },
--     todo = {
--       raw = "[!TODO]",
--       rendered = "󰗡 Todo",
--       highlight = "RenderMarkdownInfo",
--       category = "obsidian",
--     },
--     hint = {
--       raw = "[!HINT]",
--       rendered = "󰌶 Hint",
--       highlight = "RenderMarkdownSuccess",
--       category = "obsidian",
--     },
--     success = {
--       raw = "[!SUCCESS]",
--       rendered = "󰄬 Success",
--       highlight = "RenderMarkdownSuccess",
--       category = "obsidian",
--     },
--     check = {
--       raw = "[!CHECK]",
--       rendered = "󰄬 Check",
--       highlight = "RenderMarkdownSuccess",
--       category = "obsidian",
--     },
--     done = {
--       raw = "[!DONE]",
--       rendered = "󰄬 Done",
--       highlight = "RenderMarkdownSuccess",
--       category = "obsidian",
--     },
--     question = {
--       raw = "[!QUESTION]",
--       rendered = "󰘥 Question",
--       highlight = "RenderMarkdownWarn",
--       category = "obsidian",
--     },
--     help = {
--       raw = "[!HELP]",
--       rendered = "󰘥 Help",
--       highlight = "RenderMarkdownWarn",
--       category = "obsidian",
--     },
--     faq = {
--       raw = "[!FAQ]",
--       rendered = "󰘥 Faq",
--       highlight = "RenderMarkdownWarn",
--       category = "obsidian",
--     },
--     attention = {
--       raw = "[!ATTENTION]",
--       rendered = "󰀪 Attention",
--       highlight = "RenderMarkdownWarn",
--       category = "obsidian",
--     },
--     failure = {
--       raw = "[!FAILURE]",
--       rendered = "󰅖 Failure",
--       highlight = "RenderMarkdownError",
--       category = "obsidian",
--     },
--     fail = {
--       raw = "[!FAIL]",
--       rendered = "󰅖 Fail",
--       highlight = "RenderMarkdownError",
--       category = "obsidian",
--     },
--     missing = {
--       raw = "[!MISSING]",
--       rendered = "󰅖 Missing",
--       highlight = "RenderMarkdownError",
--       category = "obsidian",
--     },
--     danger = {
--       raw = "[!DANGER]",
--       rendered = "󱐌 Danger",
--       highlight = "RenderMarkdownError",
--       category = "obsidian",
--     },
--     error = {
--       raw = "[!ERROR]",
--       rendered = "󱐌 Error",
--       highlight = "RenderMarkdownError",
--       category = "obsidian",
--     },
--     bug = {
--       raw = "[!BUG]",
--       rendered = "󰨰 Bug",
--       highlight = "RenderMarkdownError",
--       category = "obsidian",
--     },
--     example = {
--       raw = "[!EXAMPLE]",
--       rendered = "󰉹 Example",
--       highlight = "RenderMarkdownHint",
--       category = "obsidian",
--     },
--     quote = {
--       raw = "[!QUOTE]",
--       rendered = "󱆨 Quote",
--       highlight = "RenderMarkdownQuote",
--       category = "obsidian",
--     },
--     cite = {
--       raw = "[!CITE]",
--       rendered = "󱆨 Cite",
--       highlight = "RenderMarkdownQuote",
--       category = "obsidian",
--     },
--   },
--
--   bullet = {
--     -- Useful context to have when evaluating values.
--     -- | level | how deeply nested the list is, 1-indexed          |
--     -- | index | how far down the item is at that level, 1-indexed |
--     -- | value | text value of the marker node                     |
--
--     -- Turn on / off list bullet rendering
--     enabled = true,
--     -- Additional modes to render list bullets
--     render_modes = false,
--     -- Replaces '-'|'+'|'*' of 'list_item'.
--     -- If the item is a 'checkbox' a conceal is used to hide the bullet instead.
--     -- Output is evaluated depending on the type.
--     -- | function   | `value(context)`                                    |
--     -- | string     | `value`                                             |
--     -- | string[]   | `cycle(value, context.level)`                       |
--     -- | string[][] | `clamp(cycle(value, context.level), context.index)` |
--     icons = { "●", "○", "◆", "◇" },
--     -- Replaces 'n.'|'n)' of 'list_item'.
--     -- Output is evaluated using the same logic as 'icons'.
--     ordered_icons = function(ctx)
--       local value = vim.trim(ctx.value)
--       local index = tonumber(value:sub(1, #value - 1))
--       return ("%d."):format(index > 1 and index or ctx.index)
--     end,
--     -- Padding to add to the left of bullet point.
--     -- Output is evaluated depending on the type.
--     -- | function | `value(context)` |
--     -- | integer  | `value`          |
--     left_pad = 0,
--     -- Padding to add to the right of bullet point.
--     -- Output is evaluated using the same logic as 'left_pad'.
--     right_pad = 1,
--     -- Highlight for the bullet icon.
--     -- Output is evaluated using the same logic as 'icons'.
--     highlight = "RenderMarkdownBullet",
--     -- Highlight for item associated with the bullet point.
--     -- Output is evaluated using the same logic as 'icons'.
--     scope_highlight = {},
--   },
-- }

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
