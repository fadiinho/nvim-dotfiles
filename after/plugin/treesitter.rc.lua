local status, _ = pcall(require, 'nvim-treesitter')
if not status then return end

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "lua",
    "python",
    "rust",
    "typescript",
    "javascript",
    "tsx",
    "markdown",
    "markdown_inline",
    "html",
    "svelte",
    "css",
    "jsonc",
    "comment",
    "bash"
  },
  auto_install = true,
  highlight = {
    enable = true
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
    disable = { "html" },
    extended_mode = false
  },
  autopairs = true,
  autotag = true,
  indent = false,
  incremental_selection = true
}
