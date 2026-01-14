return {
	-- -- the colorscheme should be available when starting Neovim
	-- {
	--   "folke/tokyonight.nvim",
	--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--   priority = 1000, -- make sure to load this before all the other start plugins
	--   config = function()
	--     -- load the colorscheme here
	--     vim.cmd([[colorscheme tokyonight]])
	--   end,
	-- },
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			-- vim.cmd("colorscheme onedark")
			-- vim.cmd("colorscheme onelight")
			-- vim.cmd("colorscheme onedark_vivid")
			-- vim.cmd("colorscheme onedark_dark")
			vim.cmd("colorscheme vaporwave")
		end,
	},
}
