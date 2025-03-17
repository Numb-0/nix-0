-- Changes :Explore visualization tree
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Makes you see line number
opt.number = true

-- Tabs and Indentation
opt.tabstop = 2 -- Tab = 2 spaces
opt.shiftwidth =  2 -- 2 spaces indentation
opt.expandtab = true -- tabs are spaces
opt.autoindent = true -- copy indentation when starting new line

opt.wrap = false -- do not wrap lines

-- search
opt.ignorecase = true -- ignores case when searching
opt.smartcase = true -- if using mixed case, assume case-sensitive

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split
opt.splitright = true
opt.splitbelow = true
