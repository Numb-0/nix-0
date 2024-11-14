return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local nvimtree = require("nvim-tree")

        nvimtree.setup({
          update_cwd = true,
          view = {
            width = 35,
            number = true,
          },
        })

        -- Tree Keymaps
        local keymap = vim.keymap
        keymap.set("n", "<leader>et", "<cmd>NvimTreeToggle<CR>", {desc = "Toggle nvim-tree"})
        keymap.set("n", "<leader>ee", "<cmd>NvimTreeFocus<CR>", {desc = "Focus nvim-tree"})
        keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", {desc = "Toggle nvim-tree at current buffer"})
    end
}
