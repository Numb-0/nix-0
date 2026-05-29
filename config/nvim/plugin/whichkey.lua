vim.pack.add({ "https://github.com/folke/which-key.nvim" })
vim.pack.add({ "https://github.com/echasnovski/mini.icons" })

require("mini.icons").setup()

local wk = require("which-key")

wk.setup({
  delay = 300,
})

wk.add({
  -- Groups
  { "<leader>f", group = "Find",    icon = { icon = "󰍉 ", color = "blue" } },
  { "<leader>b", group = "Buffer",  icon = { icon = "󰓩 ", color = "cyan" } },
  { "<leader>s", group = "Split",   icon = { icon = "󰤻 ", color = "purple" } },

  -- Find
  { "<leader>ff", desc = "Files",        icon = { icon = " ", color = "blue" } },
  { "<leader>fb", desc = "Buffers",      icon = { icon = "󰓩 ", color = "cyan" } },
  { "<leader>fg", desc = "Grep (live)",  icon = { icon = "󰍉 ", color = "blue" } },
  { "<leader>fh", desc = "Help",         icon = { icon = "󰋖 ", color = "yellow" } },
  { "<leader>fr", desc = "Resume",       icon = { icon = "󰑐 ", color = "green" } },

  -- Buffer
  { "<leader>bn", "<cmd>enew<CR>",    desc = "New",   icon = { icon = " ", color = "cyan" } },
  { "<leader>bx", "<cmd>bdelete<CR>", desc = "Close", icon = { icon = "󰅙 ", color = "red" } },

  -- Splits
  { "<leader>sh", "<cmd>split<CR>",  desc = "Horizontal", icon = { icon = "󰤻 ", color = "purple" } },
  { "<leader>sv", "<cmd>vsplit<CR>", desc = "Vertical",   icon = { icon = "󰤼 ", color = "purple" } },

  -- Top-level
  { "<leader>e", desc = "Explorer",       icon = { icon = "󰙅 ", color = "yellow" } },
  { "<leader>t", desc = "Terminal",       icon = { icon = " ", color = "red" } },
  { "<leader>/", desc = "Comment toggle", icon = { icon = "󰅺 ", color = "green" } },
  { "<leader>?", function() wk.show() end, desc = "Keybinds", icon = { icon = "󰋖 ", color = "yellow" } },

  -- Tabs (shown in which-key for discoverability)
  { "<Tab>",   desc = "Next buffer",     mode = "n", icon = { icon = "󰒭 ", color = "cyan" } },
  { "<S-Tab>", desc = "Prev buffer",     mode = "n", icon = { icon = "󰒮 ", color = "cyan" } },
})
