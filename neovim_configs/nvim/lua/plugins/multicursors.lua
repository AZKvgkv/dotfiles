return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  dependencies = { "nvimtools/hydra.nvim" },
  opts = {},
  keys = {
    { "<leader>m", "<cmd>MCstart<cr>", desc = "Create multi cursor" },
  },
}
