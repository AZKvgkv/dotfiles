local keymap = vim.keymap.set
local opts = {
  noremap = true,
  silent = true,
}

-- keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("i", "jk", "<Esc>", opts)
