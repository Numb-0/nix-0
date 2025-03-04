return {
  { "rebelot/kanagawa.nvim", priority = 1000 },
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      local cat = require("catppuccin")
      cat.setup({ flavour = "macchiato" })

      vim.cmd.colorscheme "gruvbox"
    end
  }
}
