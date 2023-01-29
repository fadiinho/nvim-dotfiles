local augroup = vim.api.nvim_create_augroup

local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "PostYankColor",
      timeout = 50,
    }
  end,
})

autocmd("BufRead", {
  pattern = "*.cs",
  callback = function()
    vim.cmd [[ TSEnable highlight ]]
  end,
})
