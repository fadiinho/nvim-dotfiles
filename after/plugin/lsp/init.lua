local status, _ = pcall(require, "lspconfig")
if not status then
  return
end

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config {
  virtual_text = true,
  signs = { active = signs },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focused = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>ll", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- local formatting_callback = function(client, bufnr)
--   vim.keymap.set("n", "<leader>f", function()
--     local params = vim.lsp.util.make_formatting_params {}
--     client.request("textDocument/formatting", params, nil, bufnr)
--   end, { buffer = bufnr })
-- end

local function disable_formatting(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

local function disable_formatting_and_attach(client, bufnr)
  disable_formatting(client)
  on_attach(client, bufnr)
end

require("lspconfig").pyright.setup {
  on_attach = function(client, bufnr)
    disable_formatting_and_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

require("lspconfig").tsserver.setup {
  on_attach = function(client, bufnr)
    disable_formatting_and_attach(client, bufnr)
  end,
  filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
}

require("lspconfig").rust_analyzer.setup {
  on_attach = disable_formatting_and_attach,
  capabilities = capabilities,
}

require("lspconfig").html.setup {
  on_attach = disable_formatting_and_attach,
  provideFormatter = false,
  capabilities = capabilities,
}

require("lspconfig").sumneko_lua.setup {
  on_attach = function(client, bufnr)
    disable_formatting_and_attach(client, bufnr)
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VINRUNTIME/lua/vim/lsp"] = true,
        },
      },
    },
  },
  capabilities = capabilities,
}
