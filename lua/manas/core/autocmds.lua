local api = vim.api

local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

local manas_group = augroup("Manas", { clear = true })
local yank_group = augroup("HighlightYank", { clear = true })

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.hl.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

autocmd("BufWritePre", {
    group = manas_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd("FileType", {
    group = manas_group,
    pattern = "java",
    callback = function()
        local opt = vim.opt_local

        opt.tabstop = 8
        opt.softtabstop = 8
        opt.shiftwidth = 8
        opt.expandtab = true
        opt.cindent = true
        opt.cinoptions = "g0,:0,N-s,(0"
        opt.indentexpr = ""
    end,
})

autocmd("FileType", {
    group = manas_group,
    pattern = { "text", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
    end,
})

autocmd("LspAttach", {
    group = manas_group,
    callback = function(event)
        local opts = { buf = event.buf }
        local cmd = vim.cmd
        local lsp = vim.lsp
        local diagnostic = vim.diagnostic
        local keymap = vim.keymap

        keymap.set("n", "gd", lsp.buf.definition, opts)

        keymap.set("n", "<leader>vgd", function()
            cmd("vsplit")
            lsp.buf.definition()
        end, opts)

        keymap.set("n", "<leader>sgd", function()
            cmd("split")
            lsp.buf.definition()
        end, opts)

        keymap.set("n", "K", function()
            local active = lsp.get_clients({ bufnr = event.buf })

            if #active > 0 then
                lsp.buf.hover()
            else
                cmd("normal! K")
            end
        end, opts)

        keymap.set("n", "<leader>vws", lsp.buf.workspace_symbol, opts)
        keymap.set("n", "<leader>vd", diagnostic.open_float, opts)
        keymap.set("n", "<leader>vca", lsp.buf.code_action, opts)
        keymap.set("n", "<leader>f", lsp.buf.format, opts)
        keymap.set("n", "<leader>vrr", lsp.buf.references, opts)
        keymap.set("n", "<leader>vrn", lsp.buf.rename, opts)
        keymap.set("i", "<C-h>", lsp.buf.signature_help, opts)

        keymap.set("n", "[d", function()
            diagnostic.jump({ count = -1 })
        end, opts)

        keymap.set("n", "]d", function()
            diagnostic.jump({ count = 1 })
        end, opts)
    end,
})
