local colors = require("lua.plugins.feline.utils").colors
local components = require "lua.plugins.feline.components"

return {
  "feline-nvim/feline.nvim",
  dependencies = { "lewis6991/gitsigns.nvim" },
  init = function()
    require("feline").setup {
      disable = { filetypes = { "^NvimTree$", "^neo%-tree$", "^dashboard$", "^Outline$", "^aerial$" } },
      theme = {
        fg = colors.light_100,
        bg = colors.cmyk_black,
      },
      components = components,
    }
  end,
}
