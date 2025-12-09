function ColorMyPencils(color)
    color = color or "rose-pine" -- Garantir que o tokyonight seja o valor default
    vim.cmd.colorscheme(color)

    -- Configurações adicionais para transparência
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })


    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#6a6a6a', bold = true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#6a6a6a', bold = true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#6a6a6a', bold = true })
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                styles = { italic = false },
            })
            -- vim.cmd.colorscheme("rose-pine")
        end
    },
}
