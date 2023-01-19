local settings = {
  opt = {
    clipboard = "unnamedplus",
    completeopt = { "menuone", "noselect" },
    copyindent = true,
    cursorline = true,
    fileencoding = "utf-8",
    fillchars = { eob = " " },
    list = true,
    -- listchars = " ,,,nbsp:",
    listchars = "tab:▷ ,trail:·",
    mouse = "a",
    number = true,
    preserveindent = true,
    relativenumber = true,
    scrolloff = 8,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    signcolumn = "yes",
    smartcase = true,
    ignorecase = true,
    swapfile = false,
    termguicolors = true,
    undofile = true,
    timeoutlen = 300,
    wrap = false,
    updatetime = 50,
    hlsearch = false,
    incsearch = true,
    colorcolumn = "80",
  },
  g = {
    mapleader = " ",
  },
}

for settingsKey in pairs(settings) do
  for key, value in pairs(settings[settingsKey]) do
    vim[settingsKey][key] = value
  end
end

vim.cmd [[colorscheme base16-pop]]
