local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

-- For ez access: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
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
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
}
