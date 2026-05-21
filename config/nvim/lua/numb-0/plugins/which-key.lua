return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>f",  group = "Telescope",  icon = { icon = " ", color = "blue" } },
      { "<leader>w",  group = "Session",    icon = { icon = " ", color = "azure" } },
      { "<leader>t",  group = "Terminal",   icon = { icon = " ", color = "red" } },
      { "<leader>p",  group = "Python",     icon = { icon = " ", color = "yellow" } },
      { "<leader>r",  group = "LSP",        icon = { icon = " ", color = "blue" } },
      { "<leader>c",  group = "Git",        icon = { icon = " ", color = "orange" } },
    })
  end,
}
