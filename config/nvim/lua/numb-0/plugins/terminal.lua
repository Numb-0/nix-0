return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local term = require("toggleterm")

    local keymap = vim.keymap
    keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<Cr>', {desc = "Toggle Terminal"})

    term.setup({
      open_mapping = [[<c-\>]],
      insert_mappings = true,
      start_in_insert = true,
      terminal_mappings = true,
      close_on_exit = true,
      size = 13,
    })

    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts) -- Exit terminal mode
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)  -- Go to window up
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

  end,
}

