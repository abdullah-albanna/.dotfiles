require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Nvim DAP UI
map("n", "<Leader>du", "<cmd>lua require'dapui'.toggle()<CR>", { desc = "open up the dap ui" })

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Debugger set conditional breakpoint" }
)

map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- moving the line up and down
map("n", "<A-C-k>", ":m .-2<CR>==", { noremap = true, silent = true })
map("n", "<A-C-j>", ":m .+1<CR>==", { noremap = true, silent = true })

map("v", "<A-C-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
map("v", "<A-C-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- LSP-related keymaps
map("n", "<Leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "code action" })
map("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "goto definition" })
map("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "goto declaration" })
map("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true, desc = "goto implementation" })
map("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "goto references" })
map("n", "<Leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "rename" })

-- open up the full error
map("n", "E", vim.diagnostic.open_float)

-- opens up a telescope of todos
map("n", "<Leader>td", "<cmd>TodoTelescope<CR>", { noremap = true, silent = true, desc = "open todos" })

-- toggle inlay hints
map("n", "<Leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints", noremap = true, silent = true })
