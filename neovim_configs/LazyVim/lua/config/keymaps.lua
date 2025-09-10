-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)
map("i", "jk", "<Esc>", opts)
-- map("n", "<C-a>", "gg<S-v>G", opts)

map("n", "<leader>-", "<CMD>split<CR>", opts)
map("n", "<leader>\\", "<CMD>vsplit<CR>", opts)

map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
