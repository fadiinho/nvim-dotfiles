local highlights = {
  PostYankColor = { bg = "#00ff00" },
  Error = { fg = "NONE", bg = "NONE" },
}

for group, attrs in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, attrs)
end
