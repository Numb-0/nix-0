vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>", {desc = "Clear Filters"})

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number"})
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number"})
keymap.set("n", "_", "-", { desc = "Go Down"})

keymap.set("n", "<leader>b", "<cmd>tabnew<CR>", {desc = "Open new tab"})
keymap.set("n", "<leader>c", "<cmd>tabclose<CR>", {desc = "Close current tab"})
keymap.set("n", "<Tab>", "<cmd>tabn<CR>", {desc = "Go to next tab"})
keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", {desc = "Go to previous tab"})

keymap.set("i", "jk", "<Esc>", {desc = "Esc"})

-- Rebind Ctrl-c to yank (copy) in normal, visual, and visual-line modes
keymap.set({'n', 'v', 'x'}, '<C-x>', '"+y')

-- Rebind Ctrl-v to paste from the system clipboard in normal, visual, and visual-line modes
keymap.set({'n', 'v', 'x'}, '<C-v>', '"+p')




