return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/","~/Dev/", "~/Dowloads", "~/Documents", "~/Desktop/" },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore Session" })
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save Session" })
  end,
}
