return {
  "giusgad/pets.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
  init = function()
    require("pets").setup {}
  end,
}
