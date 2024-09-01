-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
-- size up/down split windows
keymap.set("n", "<leader>su", "<C-w>+", { desc = "Increase split window size" }) -- increase split window size  
keymap.set("n", "<leader>sd", "<C-w>-", { desc = "Decrease split window size" }) -- decrease split window size

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- terminal keymaps
keymap.set("n", "<leader>tt", "<cmd>botright 10split term://zsh<CR>", { desc = "Open terminal in split window" }) -- open terminal in split window
keymap.set("t", "<C-q>", "<C-\\><C-n>", { desc = "Exit terminal" }) -- exit terminal

-- buffer keymaps
keymap.set("n", "<leader>ba", '<C-6>', { desc = "Switch to previous buffer" }) -- switch to previous buffer
keymap.set("n", "<leader>bn", '<cmd>bn<CR>', { desc = "Switch to next buffer" }) -- switch to next buffer
keymap.set("n", "<leader>bp", '<cmd>bp<CR>', { desc = "Switch to previous buffer" }) -- switch to previous buffer
keymap.set("n", "<leader>bd", '<cmd>bd<CR>', { desc = "Close current buffer" }) -- close current buffer
keymap.set("n", "<leader>bl", '<cmd>ls<CR>', { desc = "List all buffers" }) -- list all buffers
