vim.g.mapleader = " "

local keymap = vim.keymap

-- Clear highlights on Esc
keymap.set("n", "<Esc>", "<cmd>nohl<CR>", { desc = "Clear highlights" })

-- Save file
-- keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

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

-- Number increment/decrement
-- keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Line number toggles
-- keymap.set("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
-- keymap.set("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

-- Buffer management
keymap.set("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })
keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })
keymap.set("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Previous tab" })

-- Escape insert mode
keymap.set("i", "jk", "<Esc>", { desc = "Escape insert mode" })

-- System clipboard
-- keymap.set({ "n", "v", "x" }, "<C-x>", '"+y', { desc = "Copy to system clipboard" })

-- Comment toggle (native gc operator via ts-context-commentstring)
-- keymap.set("n", "<leader>/", "gcc", { desc = "Toggle comment line", remap = true })
-- keymap.set("v", "<leader>/", "gc", { desc = "Toggle comment selection", remap = true })

-- WhichKey
-- keymap.set("n", "<leader>wK", "<cmd>WhichKey<CR>", { desc = "WhichKey all keymaps" })
-- keymap.set("n", "<leader>wk", function()
--   vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
-- end, { desc = "WhichKey query lookup" })
