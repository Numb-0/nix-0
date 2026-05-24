vim.g.mapleader = " "

local keymap = vim.keymap

-- Clear highlights on Esc
keymap.set("n", "<Esc>", "<cmd>nohl<CR>", { desc = "Clear highlights" })

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })

-- Insert mode navigation
keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
keymap.set("i", "<C-e>", "<End>", { desc = "Move end of line" })
keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })

-- Buffer management
keymap.set("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })
keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })
keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Escape insert mode
keymap.set("i", "jk", "<Esc>", { desc = "Escape insert mode" })

