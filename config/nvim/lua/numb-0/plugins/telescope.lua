return {
  "nvim-telescope/telescope.nvim", tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
  config = function()
    local telescope = require("telescope")
    telescope.load_extension("fzf")


    -- Telescope Keymaps
    local builtin = require("telescope.builtin")
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
    keymap.set("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "Telescope find all files" })
    keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Telescope live grep" })
    keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope find buffers" })
    keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help page" })
    keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope find oldfiles" })
    keymap.set("n", "<leader>fz", builtin.current_buffer_fuzzy_find, { desc = "Telescope find in current buffer" })
    keymap.set("n", "<leader>cm", builtin.git_commits, { desc = "Telescope git commits" })
    keymap.set("n", "<leader>gt", builtin.git_status, { desc = "Telescope git status" })
    keymap.set("n", "<leader>ma", builtin.marks, { desc = "Telescope find marks" })


    telescope.setup({
      pickers = {
        find_files = {
          file_ignore_patterns = { 'node_modules', '.git', '.venv' },
            hidden = true
          },
      },
    })
  end
}
