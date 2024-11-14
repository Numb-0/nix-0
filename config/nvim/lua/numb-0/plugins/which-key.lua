return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    local wk = require("which-key")

    wk.add({
      {"<leader>e", group = "Nvim-Tree", icon = {icon=" ", color = "green"} },
      {"<leader>f", group = "Telescope", icon = {icon=" ", color = "blue"} },
      {"<leader>w", group = "Session", icon = {icon = " ", color = "azure"} },
      {"<leader>t", group = "Terminal", icon = {icon = " ", color = "red"} },
      {"<leader>tt", icon = {icon = " ", color = "red"} },
    })
  end,
  opts = {
  },
}
