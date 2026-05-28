local servers = {
    jdtls = {},

    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = {
                    globals = { "vim", "bit", "it", "describe", "before_each", "after_each" },
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
                telemetry = { enable = false },
            },
        },
    },

    pyright = {
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    typeCheckingMode = "basic",
                    useLibraryCodeForTypes = true,
                },
            },
        },
    },

    clangd = {
        cmd = {
            "clangd",
            "--enable-config",
        },
    },
}

return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },

    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.diagnostic.config({
                severity_sort = true,
                float = {
                    border = "rounded",
                    focusable = false,
                    header = "",
                    prefix = "",
                    source = "always",
                    style = "minimal",
                },
            })

            for server, config in pairs(servers) do
                config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
                vim.lsp.config(server, config)
            end

            require("mason-lspconfig").setup({
                ensure_installed = vim.tbl_keys(servers),
            })
        end,
    },

    {
        "j-hui/fidget.nvim",
        opts = {},
    },
}
