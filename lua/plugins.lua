vim.api.nvim_create_augroup('packer_conf', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  desc = 'Sync packer after modifying plugins.lua',
  group = 'packer_conf',
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerInstall',
})

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Neotree
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  -- Theme
  use 'techygrrrl/techygrrrl-cmyk-colourrrs-neovim'

  -- LSP
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind.nvim'

  -- Auto Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Terminal
  use {
    "akinsho/toggleterm.nvim",
    tag = "*"
  }

  -- Better escape
  use {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
  }

  -- Bufferline
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons'
  }
end)
