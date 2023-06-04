return {
  "windwp/nvim-ts-autotag",
  ft = { "html", "tsx" },
  init = function()
    local autotag = require "nvim-ts-autotag"
    autotag.setup()
  end,
}
