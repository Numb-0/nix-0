vim.pack.add({ "https://github.com/akinsho/toggleterm.nvim" })

local term = require("toggleterm")
local Terminal = require("toggleterm.terminal").Terminal

local horiz_term = Terminal:new({ direction = "horizontal" })

vim.keymap.set({ "n", "t" }, "<leader>t", function() horiz_term:toggle() end, { desc = "Terminal toggle" })

term.setup({
  start_in_insert = true,
  close_on_exit   = true,
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<C-x>", [[<C-\><C-n>]],        opts)
  vim.keymap.set("t", "jk",    [[<C-\><C-n>]],        opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
