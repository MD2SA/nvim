return {
    "neovim/nvim-lspconfig",
    dependencies = { -- Dependências necessárias para o funcionamento
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "jdtls",
                "lua_ls",
                "pyright",
                "clangd",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,


                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities, -- Passa as capacidades configuradas
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    })
                end,
                ["pyright"] = function()
                    require("lspconfig").pyright.setup({
                        capabilities = capabilities,
                        settings = {
                            python = {
                                analysis = {
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true,
                                    diagnosticMode = "workspace",
                                    typeCheckingMode = "basic",
                                },
                            },
                        },
                    })
                end,
                ["clangd"] = function()
                    require("lspconfig").clangd.setup({
                        capabilities = capabilities,
                        cmd = {
                            "clangd",
                            "--fallback-style={IndentWidth: 8, TabWidth: 8, UseTab: Never, ColumnLimit: 0}",
                            "--all-scopes-completion",
                            "--completion-style=detailed",
                            "--header-insertion=never",
                            "--header-insertion-decorators",
                            "--background-index",
                            "--clang-tidy",
                        },
                    })
                end,
            }
        })



        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- Expande snippets com o LuaSnip
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select), -- Atalho para selecionar item anterior
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select), -- Atalho para selecionar próximo item
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),   -- Confirma a seleção do item
                ["<C-Space>"] = cmp.mapping.complete(),               -- Aciona o menu de autocompletar
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
