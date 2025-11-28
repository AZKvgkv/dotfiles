require("config.lazy")
require("az")

require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true, -- 模糊匹配
			override_generic_sorter = true,
			override_file_sorter = true,
		},
	},
})
require("telescope").load_extension("fzf")

-- 常用映射
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>rg", builtin.live_grep)

-- theme & transparency
vim.cmd.colorscheme("unokai")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
