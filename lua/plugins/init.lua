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
  -- LSP

  -- Plugins that don't need config
  "williamboman/mason-lspconfig.nvim",
  "pantharshit00/vim-prisma",

  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
  },
}
