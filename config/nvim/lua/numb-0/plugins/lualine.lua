return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    local colors = {
      overlay1 = "#8087a2",
      surface1 = "#494d64",
      crust = "#181926",
      text = "#cad3f5",
      green = "#a6da95",
      red = "#ed8796",
      mauve = "#c6a0f6",
      yellow = "#eed49f",
      blue = "#8aadf4",
      peach = "#f5a97f",
    }

    local custom_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.crust, gui = "bold"},
        b = { bg = colors.crust, fg = colors.text },
        c = { bg = colors.crust, fg = colors.text },
      },
      insert = {
        a = { bg = colors.green, fg = colors.crust, gui = "bold"},
        b = { bg = colors.crust, fg = colors.text },
        c = { bg = colors.crust, fg = colors.text },
      },
      visual = {
        a = { bg = colors.mauve, fg = colors.crust, gui = "bold"},
        b = { bg = colors.crust, fg = colors.text },
        c = { bg = colors.crust, fg = colors.text},
      },
      command = {
        a = { bg = colors.yellow, fg = colors.crust, gui = "bold"},
        b = { bg = colors.crust, fg = colors.text },
        c = { bg = colors.crust, fg = colors.text },
      },
      replace = {
        a = { bg = colors.red, fg = colors.crust, gui = "bold"},
        b = { bg = colors.crust, fg = colors.text },
        c = { bg = colors.crust, fg = colors.text },
      },
      inactive = {
        a = { bg = colors.crust, fg = colors.text, gui = "bold"},
        b = { bg = colors.crust, fg = colors.text },
        c = { bg = colors.crust, fg = colors.text },
      },
      terminal = {
        a = { bg = colors.peach, fg = colors.crust, gui = "bold"},
        b = { bg = colors.crust, fg = colors.text },
        c = { bg = colors.crust, fg = colors.text },
      }
    }
    lualine.setup({
      options = {
        theme = custom_theme,
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = colors.mauve },
          },
          { "encoding" },
          { "filetype" },
        },
      },
    })
  end,
}
