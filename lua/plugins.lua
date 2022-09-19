vim.api.nvim_create_augroup("packer_conf", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Sync packer after modifying plugins.lua",
  group = "packer_conf",
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
})

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'techygrrrl/techygrrrl-cmyk-colourrrs-neovim'
end)
