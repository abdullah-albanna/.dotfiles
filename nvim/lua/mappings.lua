require "nvchad.mappings"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function merge_opts(extra)
  return vim.tbl_extend("force", opts, extra or {})
end

-- DAP UI
map("n", "<Leader>du", "<cmd>lua require'dapui'.toggle()<CR>", merge_opts { desc = "open up the dap ui" })

-- DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", merge_opts { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", merge_opts { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", merge_opts { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", merge_opts { desc = "Debugger continue" })
map(
  "n",
  "<Leader>db",
  "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
  merge_opts { desc = "Debugger toggle breakpoint" }
)
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  merge_opts { desc = "Debugger set conditional breakpoint" }
)

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

-- moving lines
map("n", "<A-C-k>", ":m .-2<CR>==", opts)
map("n", "<A-C-j>", ":m .+1<CR>==", opts)
map("v", "<A-C-k>", ":m '<-2<CR>gv=gv", opts)
map("v", "<A-C-j>", ":m '>+1<CR>gv=gv", opts)

-- LSP
map("n", "<Leader>ca", vim.lsp.buf.code_action, merge_opts { desc = "code action" })
map("n", "gd", vim.lsp.buf.definition, merge_opts { desc = "goto definition" })
map("n", "gD", vim.lsp.buf.declaration, merge_opts { desc = "goto declaration" })
map("n", "gi", vim.lsp.buf.implementation, merge_opts { desc = "goto implementation" })
map("n", "gr", vim.lsp.buf.references, merge_opts { desc = "goto references" })
map("n", "<Leader>rn", vim.lsp.buf.rename, merge_opts { desc = "rename" })

map("n", "E", vim.diagnostic.open_float, opts)

map("n", "<Leader>td", "<cmd>TodoTelescope<CR>", merge_opts { desc = "open todos" })

map("n", "<Leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, merge_opts { desc = "Toggle inlay hints" })

-- Movement tweaks
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Don't yank on delete/change
map("n", "d", '"_d', opts)
map("n", "D", '"_D', opts)
map("n", "c", '"_c', opts)
map("n", "C", '"_C', opts)
map("n", "x", '"_x', opts)
map("n", "X", '"_X', opts)
map("v", "d", '"_d', opts)
map("v", "x", '"_x', opts)

-- Reselect again when indenting with > or <
map("v", ">", ">gv", opts)
map("v", "<", "<gv", opts)

-- map("n", "K", require("hover").hover, { desc = "hover.nvim" })
-- map("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
