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

autocmd("BufEnter", {
  pattern = { "*.dart", "*.lua" },
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
  end,
})

autocmd("BufWritePre", {
  pattern = { "*.dart" },
  callback = function()
    vim.cmd "silent! !kill -SIGUSR1 $(pgrep -f '[f]lutter_tool.*run')"
  end,
})

autocmd("FileType", {
  pattern = "*",
  callback = function()
    local ignored = { "neo-tree", "toggleterm", "TelescopePrompt", "help", "lazy", "mason" }
    if vim.tbl_contains(ignored, vim.bo.filetype) then
      return
    end
    vim.cmd [[match TrailinWhiteSpace /\s\+$/]]
  end,
})
