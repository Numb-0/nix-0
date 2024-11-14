return {
  "akinsho/bufferline.nvim", version = "*",
  dependecies = "nvim-tree/nvim-web-devicons",
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        mode = "tabs",
        separator_style = "slant",
        offsets = {
          {
            filetype = "NvimTree",
            text = "Tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
       },
    })
  end
}
