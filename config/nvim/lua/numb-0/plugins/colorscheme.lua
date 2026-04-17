return {
  { "rebelot/kanagawa.nvim", priority = 1000 },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        transparent_mode = false,
      })
      vim.cmd.colorscheme "gruvbox"
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
    },
  },
}
