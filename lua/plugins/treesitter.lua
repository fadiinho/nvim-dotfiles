return {
  "nvim-treesitter/nvim-treesitter",
  cmd = "TSUpdate",
  init = function ()
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
          enable = false,
        },
        autotag = {
          enable = true,
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
        indent = { enable = true },
        incremental_selection = true,
      }
  end
}
