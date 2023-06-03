return {
  "stevearc/dressing.nvim",
  event = "VimEnter",
  init = function()
    require("dressing").setup {
      input = {
        enabled = true,
        default_prompt = "➤ ",
        win_options = {
          winhighlight = "Normal:Normal,NormalNC:Normal",
        },
      },
      select = {
        enabled = true,
        backend = { "telescope", "builtin" },
        builtin = {
          win_options = {
            winhighlight = "Normal:Normal,NormalNC:Normal",
          },
        },
      },
    }
  end,
}
