return {
  "lukas-reineke/indent-blankline.nvim",
  enabled = false,
  init = function()
    vim.cmd [[highlight IndentBlanklineContextChar guifg=#aaaaaa gui=nocombine]]

    require("indent_blankline").setup {
      show_current_context = true,
    }
  end,
}
