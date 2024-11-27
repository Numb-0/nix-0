return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  config = function()
    local cat = require("catppuccin")
    cat.setup({
      flavour = "macchiato",
      integrations = {
        indent_blankline = {
          enabled = true,
          scope_color = "yellow", -- catppuccin color (eg. `lavender`) Default: text
        },
      },
    })

    vim.cmd.colorscheme "catppuccin"
  end
}
