local highlights = {
  PostYankColor = { bg = "#00ff00" },
  Error = { fg = "NONE", bg = "NONE" },
  TrailinWhiteSpace = { fg = "#ffffff", bg = "#ff0000" },
}

for group, attrs in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, attrs)
end

vim.cmd [[match TrailinWhiteSpace /\s\+$/]]
