local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- 把默认的 find_files 换成 ivy 风格
    {
      "<leader><leader>",
      function()
        builtin.find_files(themes.get_ivy())
      end,
      desc = "Find Files (ivy)",
      mode = "n",
    },
  },
}
