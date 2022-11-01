local settings = {
  opt = {
    clipboard = "unnamedplus",
    completeopt = { "menuone", "noselect" },
    copyindent = true,
    cursorline = true,
    expandtab= true,
    fileencoding = "utf-8",
    fillchars = { eob = " " },
    mouse = "a",
    number = true,
    preserveindent = true,
    relativenumber = true,
    scrolloff = 8,
    shiftwidth = 2,
    signcolumn = "yes",
    smartcase = true,
    ignorecase = true,
    swapfile = false,
    tabstop = 2,
    termguicolors = true,
    undofile = true,
    timeoutlen = 300,
    wrap = false
  },
  g = {
    mapleader = " "
  }
}

for settingsKey in pairs(settings) do
  for key, value in pairs(settings[settingsKey]) do
    vim[settingsKey][key] = value
  end
end

vim.cmd [[colorscheme base16-pop]]
vim.api.nvim_set_hl(0, "PostYankColor", { bg = "#00ff00" })
