local status, _ = pcall(require, "nvim-treesitter")
if not status then
  return
end

require("nvim-treesitter.configs").setup {
  ensure_installed = {
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
  auto_install = false,
  highlight = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = false,
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
