return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown' }, -- 👈 load only for markdown files
        dependencies = {},
        opts = {
            latex = {
                enabled = true,          -- turn on LaTeX math rendering
                converters = { 'katex' } -- uses KaTeX under the hood
            },
        },
    },
}
