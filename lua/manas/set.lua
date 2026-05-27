vim.opt.guicursor = "n:block"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java", "cpp", "c", "h", "hpp" },
    callback = function()
        vim.opt_local.tabstop = 8
        vim.opt_local.softtabstop = 8
        vim.opt_local.shiftwidth = 8
        vim.opt_local.expandtab = true
        vim.opt_local.cindent = true
        -- Adicionando cinoptions para melhor comportamento em C++
        vim.opt_local.cinoptions = "g0,:0,N-s,(0"
        -- Forçar cindent limpando o indentexpr (Treesitter/outros)
        vim.opt_local.indentexpr = ""
    end,
})

vim.opt.smartindent = false
vim.opt.autoindent = true

vim.opt.wrap = false
vim.api.nvim_create_autocmd("FileType", {
    pattern = "text",
    -- pattern = { "text", "markdown" },
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
