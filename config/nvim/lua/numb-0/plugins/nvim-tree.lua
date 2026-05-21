return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local nvimtree = require("nvim-tree")

        nvimtree.setup({
          sync_root_with_cwd = true,
          view = {
            width = 35,
            -- number = true,
            -- padding = 0
          },
        })

        -- Tree Keymaps
        local keymap = vim.keymap
        keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTree toggle" })
        keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "NvimTree focus" })
    end
}
