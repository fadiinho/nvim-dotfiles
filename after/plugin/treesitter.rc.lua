local status, _ = pcall(require, "nvim-treesitter")
if not status then
  return
end

require("nvim-treesitter.configs").setup {
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
    "bash",
  },
  auto_install = true,
  highlight = {
    enable = false,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
    disable = { "html" },
    extended_mode = false,
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  indent = { enable = false },
  incremental_selection = true,
}
