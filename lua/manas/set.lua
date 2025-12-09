vim.opt.guicursor = "n:block"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        vim.opt_local.tabstop = 8
        vim.opt.softtabstop = 8
        vim.opt_local.shiftwidth = 8
        vim.opt_local.expandtab = true
    end,
})

vim.opt.smartindent = true

vim.opt.wrap = false
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "text", "markdown" },
    callback = function()
        vim.opt.wrap = true
    end,
})

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('config') .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
-- vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "100"
