-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_particle_density = 100.0
vim.g.neovide_floating_shadow = false
vim.g.neovide_input_ime = true

-- 也可以放在init.lua中
-- vim.g.nvy = 1
-- vim.g.guifont = "CommitMono Nerd Font:h14"

local opt = vim.opt
opt.guifont = "CommitMono Nerd Font:h14"

opt.wrap = true
opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait0-blinkoff0-blinkon0-Cursor/lCursor,sm:block-blinkwait0-blinkoff0-blinkon0"
opt.list = true
opt.listchars = {
  space = "·",
}

opt.shell = "nu"
