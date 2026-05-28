local opt = vim.opt
local g = vim.g


-- Cursor
opt.guicursor = "n:block"


-- Line numbers
opt.number = true
opt.relativenumber = true


-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = false
opt.autoindent = true


-- UI
opt.wrap = false
opt.termguicolors = true
opt.scrolloff = 8
-- opt.signcolumn = "yes"
-- opt.colorcolumn = "100"
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25


-- Search
opt.hlsearch = false
opt.incsearch = true


-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.isfname:append("@-@")


-- Performance
opt.updatetime = 50
