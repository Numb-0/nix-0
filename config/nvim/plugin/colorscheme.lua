-- Colours come from chromix: the file is regenerated on every theme
-- switch, and chromix reloads it in running instances.
vim.pack.add({
  "https://github.com/nvim-mini/mini.base16"
})

pcall(dofile, vim.fn.expand("~/.local/state/chromix/current/nvim/colors.lua"))
