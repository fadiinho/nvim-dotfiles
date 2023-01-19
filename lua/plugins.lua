vim.api.nvim_create_augroup("packer_conf", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Sync packer after modifying plugins.lua",
  group = "packer_conf",
  pattern = "plugins.lua",
  command = "source <afile> | PackerInstall",
})

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  -- Neotree
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  }

  -- base16-bright
  -- base16-pico
  -- base16-summerfruit-dark
  -- base16-synth-midnight-dark
  -- base16-pop (current)

  -- Theme
  use "techygrrrl/techygrrrl-cmyk-colourrrs-neovim"
  use "thedenisnikulin/vim-cyberpunk"
  use "fnune/base16-vim"

  -- LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"
  use "onsails/lspkind.nvim"

  use "pantharshit00/vim-prisma"

  -- Auto Completion
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"

  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"

  use "honza/vim-snippets"

  use "rafamadriz/friendly-snippets"

  use "folke/which-key.nvim"
  -- Terminal
  use {
    "akinsho/toggleterm.nvim",
    tag = "*",
  }

  -- Better escape
  use {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require("better_escape").setup {
        mapping = { "jj", "jk" },
        timeout = vim.o.timeoutlen,
        clear_empty_lines = false,
        keys = "<Esc>",
      }
    end,
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- Bufferline
  use {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons",
  }

  -- Commenting
  use {
    "numToStr/Comment.nvim",
    module = { "Comment", "Comment.api" },
  }

  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  }

  -- Autopairs
  use "windwp/nvim-autopairs"
  use "windwp/nvim-ts-autotag"

  -- Null-ls
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = "jose-elias-alvarez/null-ls.nvim",
  }

  -- Dressing UI Enhancer
  use {
    "stevearc/dressing.nvim",
    event = "VimEnter",
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = { { "nvim-lua/plenary.nvim" } },
  }

  -- Feline
  use {
    "feline-nvim/feline.nvim",
    requires = { "lewis6991/gitsigns.nvim" },
  }

  -- Color Highlight #f0f0f0
  use {
    "norcalli/nvim-colorizer.lua",
  }

  use {
    "xiyaowong/nvim-transparent",
  }

  use {
    "andweeb/presence.nvim",
  }

  use "MunifTanjim/nui.nvim"

  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  }

  use "lukas-reineke/indent-blankline.nvim"
end)
