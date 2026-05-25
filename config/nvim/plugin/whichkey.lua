vim.pack.add({ "https://github.com/folke/which-key.nvim" })
vim.pack.add({ "https://github.com/echasnovski/mini.icons" })

require("mini.icons").setup()

local wk = require("which-key")

wk.add({
    { "<leader>f", group = "Files", icon = { icon = " ", color = "blue" } },
    { "<leader>t", desc = "Toggle Terminal", icon = { icon = " ", color = "red" } },
    { "<leader>/", desc = "Toggle Comment" },
    { "<leader>?", function() wk.show() end, desc = "Show all keybinds", icon = { icon = "󰋖", color = "yellow" } },
})
