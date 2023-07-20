vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-l>", "<c-w>l")
vim.keymap.set("n", "<leader>ev", ":tabe ~/.config/nvim<cr>")
-- vim.keymap.set("n", "<leader>sv", ":w $MYVIMRC<CR>:source $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>ps", ":SPS<cr>")
vim.keymap.set("n", "<leader>o", ":q<cr>")
