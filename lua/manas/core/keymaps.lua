local keymap = vim.keymap

vim.g.mapleader = " "
keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("x", "<leader>p", [["_dP]])

keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set({ "n", "v" }, "<leader>d", "\"_d")

keymap.set("i", "<C-c>", "<Esc>")

keymap.set("n", "Q", "<nop>")

keymap.set("n", "<leader>cn", ":cnext<CR>")
keymap.set("n", "<leader>cp", ":cprev<CR>")

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)

-- move between windows with ALT
keymap.set("n", "<M-h>", "<C-w>h")
keymap.set("n", "<M-j>", "<C-w>j")
keymap.set("n", "<M-k>", "<C-w>k")
keymap.set("n", "<M-l>", "<C-w>l")

-- change window sizes with alt +- X and JK for Y
keymap.set("n", "<M-+>", "5<C-w><")
keymap.set("n", "<M-->", "5<C-w>>")
keymap.set("n", "<M-J>", "2<C-w>-")
keymap.set("n", "<M-K>", "2<C-w>+")
