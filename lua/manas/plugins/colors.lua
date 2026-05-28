return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,

        opts = {
            disable_background = true,
            styles = {
                italic = false,
            },
        },

        config = function(_, opts)
            require("rose-pine").setup(opts)

            vim.cmd.colorscheme("rose-pine")

            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

            vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6a6a6a", bold = true })
            vim.api.nvim_set_hl(0, "LineNr", { fg = "#6a6a6a", bold = true })
            vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6a6a6a", bold = true })
        end,
    },
}
