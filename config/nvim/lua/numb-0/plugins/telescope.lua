return {
  "nvim-telescope/telescope.nvim", tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
  config = function()
    local telescope = require("telescope")
    telescope.load_extension("fzf")


    -- Telescope Keymaps
    local builtin = require("telescope.builtin")
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", builtin.find_files, {desc = "Telescope find files"})
    keymap.set("n", "<leader>fg", builtin.live_grep, {desc = "Telescope grep working directory"})
    keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, {desc = "Telescope grep current buffer"})
    keymap.set("n", "<leader>fh", builtin.help_tags, {desc = "Telescope help files"})

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
