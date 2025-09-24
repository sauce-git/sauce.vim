local map = vim.keymap.set

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Terminal mode window navigation
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- buffers
map("n", "[[", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]]", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix" })

-- -- Close floating windows with Escape
-- map("n", "<Esc>", function()
--   local closed_windows = 0
--   -- Close any floating windows
--   for _, win in ipairs(vim.api.nvim_list_wins()) do
--     local config = vim.api.nvim_win_get_config(win)
--     if config.relative ~= "" then
--       vim.api.nvim_win_close(win, false)
--       closed_windows = closed_windows + 1
--     end
--   end
--   if closed_windows > 0 then
--     vim.notify("Closed " .. closed_windows .. " floating windows", vim.log.levels.INFO)
--   end
--   -- Clear search highlighting
--   vim.cmd("nohlsearch")
-- end, { desc = "Close floating windows and clear search" })
