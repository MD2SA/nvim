return {
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = false,
                },
                -- Optional: Override settings for specific filetypes
                per_filetype = {
                    -- Example: Disable auto-closing for HTML files
                    -- ["html"] = {
                    --   enable_close = false,
                    -- },
                },
            })
        end,
    },
}
