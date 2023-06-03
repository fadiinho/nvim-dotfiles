return {
  "jose-elias-alvarez/null-ls.nvim",
  init = function()
    local null_ls = require "null-ls"
    local contains = require("utils").contains

    local NO_AUTO_FORMAT = { "dart" }

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local function _on_attach(client, bufnr)
      if client.supports_method "textDocument/formatting" then
        if contains(NO_AUTO_FORMAT, vim.bo.filetype) then
          return
        end

        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
    end

    -- For ez access: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with {
          prefer_local = true,
          filetypes = {
            "css",
            "markdown",
            "json",
            "jsonc",
            "html",
          },
        },
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.rome.with {
          prefer_local = "only_local",
          filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
          condition = function(utils)
            return utils.root_has_file { "rome.json" }
          end,
        },
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.dart_format,
      },
      on_attach = _on_attach,
    }
  end,
}
