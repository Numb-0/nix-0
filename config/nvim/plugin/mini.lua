vim.pack.add({ "https://github.com/nvim-mini/mini.icons" })
vim.pack.add({ "https://github.com/nvim-mini/mini.pick" })
vim.pack.add({ "https://github.com/nvim-mini/mini.comment" })
vim.pack.add({ "https://github.com/nvim-mini/mini.files" })
vim.pack.add({ "https://github.com/nvim-mini/mini.surround" })
vim.pack.add({ "https://github.com/nvim-mini/mini.diff" })
vim.pack.add({ 'https://github.com/nvim-mini/mini.cmdline' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.tabline' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.statusline' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.completion' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.pairs' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.ai' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.notify' })

-- Icons
local mini_icons = require('mini.icons')
mini_icons.setup()

-- Picker
local mini_pick = require('mini.pick')
mini_pick.setup()

local pick = mini_pick.builtin
vim.keymap.set('n', '<leader>ff', pick.files,      { desc = 'Pick files' })
vim.keymap.set('n', '<leader>fb', pick.buffers,    { desc = 'Pick buffers' })
vim.keymap.set('n', '<leader>fh', pick.help,       { desc = 'Pick help' })
vim.keymap.set('n', '<leader>fg', pick.grep_live,  { desc = 'Pick grep (live)' })
vim.keymap.set('n', '<leader>fr', pick.resume,     { desc = 'Resume last pick' })

-- Comment
local mini_comment = require('mini.comment')
mini_comment.setup({
  mappings = {
    comment_line   = '<leader>/',
    comment_visual = '<leader>/',
  },
})

-- Files
local mini_files = require('mini.files')
mini_files.setup({
  mappings = {
    go_in = '<Right>',
    go_out = '<Left>',
    show_help = '?',
  },
})
vim.keymap.set('n', '<leader>e', mini_files.open, { desc = 'Open file explorer' })

-- Surround
local mini_surround = require('mini.surround')
mini_surround.setup()

-- Diff
local mini_diff = require('mini.diff')
mini_diff.setup()

-- Cmdline
local mini_cmdline = require('mini.cmdline')
mini_cmdline.setup()

-- Tabline
local mini_tabline = require('mini.tabline')
mini_tabline.setup()

-- Statusline
local mini_statusline = require('mini.statusline')
mini_statusline.setup()

-- Completion
local mini_completion = require('mini.completion')
mini_completion.setup()

-- Pairs
local mini_pairs = require('mini.pairs')
mini_pairs.setup()

-- Extended text objects
local mini_ai = require('mini.ai')
mini_ai.setup()

-- Notifications
local mini_notify = require('mini.notify')
mini_notify.setup()
vim.notify = mini_notify.make_notify()
