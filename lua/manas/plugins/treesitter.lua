return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter").setup()

        local ensure_installed = {
            "vimdoc", "javascript", "typescript", "cpp",
            "java", "lua", "bash", "python",
        }
        
        local installed = require("nvim-treesitter").get_installed()
        local to_install = {}
        for _, lang in ipairs(ensure_installed) do
            if not vim.tbl_contains(installed, lang) then
                table.insert(to_install, lang)
            end
        end

        if #to_install > 0 then
            require("nvim-treesitter").install(to_install)
        end

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local lang = vim.treesitter.language.get_lang(vim.bo.filetype) or vim.bo.filetype
                
                local has_parser, _ = pcall(vim.treesitter.get_parser, 0, lang)
                if has_parser then
                    pcall(vim.treesitter.start)
                    
                    local disable_indent = { "cpp", "c" }
                    if not vim.tbl_contains(disable_indent, lang) then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end
            end,
        })
    end,
}
