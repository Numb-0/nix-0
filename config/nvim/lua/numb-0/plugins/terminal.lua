return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local term = require("toggleterm")
    local Terminal = require("toggleterm.terminal").Terminal

    local float_term = Terminal:new({ direction = "float" })
    local horiz_term = Terminal:new({ direction = "horizontal", size = 13 })
    local vert_term = Terminal:new({ direction = "vertical" })

    local keymap = vim.keymap

    keymap.set({ "n", "t" }, "<A-i>", function() float_term:toggle() end, { desc = "Terminal toggle float" })
    keymap.set({ "n", "t" }, "<A-h>", function() horiz_term:toggle() end, { desc = "Terminal toggle horizontal" })
    keymap.set({ "n", "t" }, "<A-v>", function() vert_term:toggle() end, { desc = "Terminal toggle vertical" })

    term.setup({
      start_in_insert = true,
      close_on_exit = true,
    })

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<C-x>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
