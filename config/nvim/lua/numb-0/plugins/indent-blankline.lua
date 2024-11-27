return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  config = function()
    local ibl = require("ibl")

    local macchiato = require("catppuccin.palettes").get_palette("macchiato")

    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }
  
    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = macchiato.red })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = macchiato.yellow })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = macchiato.blue })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = macchiato.peach })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = macchiato.green })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = macchiato.mauve })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = macchiato.teal })
    end)
    
    ibl.setup { indent = { highlight = highlight } }
  end,
}
