return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "vimdoc", "javascript", "typescript", "cpp",
                "java", "lua", "bash",
            },

            sync_install = false,
            auto_install = true,

            indent = {
                enable = true,
                disable = { "cpp", "c" },
            },

            highlight = {
                enable = true,
            },
        })
    end,
}
