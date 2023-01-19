local status, blankline = pcall(require, "indent_blankline")
if not status then
  return
end

vim.cmd [[highlight IndentBlanklineContextChar guifg=#aaaaaa gui=nocombine]]

blankline.setup {
  show_current_context = true,
}
