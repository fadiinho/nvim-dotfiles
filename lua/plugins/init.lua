return {
  -- Themes
  --thedenisnikulin/vim-cyberpunk
  --fnune/base16-vim

  -- base16-bright
  -- base16-pico
  -- base16-summerfruit-dark
  -- base16-synth-midnight-dark
  -- base16-pop (current)
  {
    "fnune/base16-vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[ colorscheme base16-pop ]]
    end,
  },

  "techygrrrl/techygrrrl-cmyk-colourrrs-neovim",

  -- Neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },

  -- LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "onsails/lspkind.nvim",

  "pantharshit00/vim-prisma",

  -- Auto Completion
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = "TSUpdate",
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "v2.*",
    dependencies = "kyazdani42/nvim-web-devicons",
  },

  -- Commenting
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter",
    },
  },

  -- Null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = "jose-elias-alvarez/null-ls.nvim",
  },

  -- Dressing UI Enhancer
  {
    "stevearc/dressing.nvim",
    event = "VimEnter",
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.1",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
  --
  -- Feline
  {
    "feline-nvim/feline.nvim",
    dependencies = { "lewis6991/gitsigns.nvim" },
  },

  -- Color Highlight #f0f0f0
  {
    "norcalli/nvim-colorizer.lua",
  },
  --
  {
    "xiyaowong/nvim-transparent",
  },

  {
    "iamcco/markdown-preview.nvim",
    -- event = "VeryLazy",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  --  use "lukas-reineke/indent-blankline.nvim"
}
