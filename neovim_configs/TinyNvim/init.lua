require("config.lazy")
require("az")

require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
		},
	},
})
require("telescope").load_extension("fzf")

--keymaps for telescope
-- local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
-- vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live_grep" })
-- vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
-- vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Telescope help tags" })

-- theme & transparency
vim.cmd.colorscheme("unokai")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- vim.o.showmode = false
