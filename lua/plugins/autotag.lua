return {
  "windwp/nvim-ts-autotag",
  init = function()
    local autotag = require "nvim-ts-autotag"
    autotag.setup()
  end,
}
