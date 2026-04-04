local _Opts = {}

_Opts.transparent = true

_Opts.plugins = {
  all = true,
}

_Opts.styles = {
  floats = "transparent",
  sidebars = "transparent",
}

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = _Opts,
  config = function(_, opts)
    require("tokyonight").setup(opts)
  end,
}
