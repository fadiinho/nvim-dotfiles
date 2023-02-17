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

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  opts.buffer = bufnr

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)

  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function disable_formatting(client)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
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
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        disabled = { "unresolved-proc-macro" },
      },
    },
  },
}

require("lspconfig").html.setup {
  on_attach = disable_formatting_and_attach,
  provideFormatter = false,
  capabilities = capabilities,
}

require("lspconfig").cssls.setup {
  on_attach = disable_formatting_and_attach,
  capabilities = capabilities,
}

require("lspconfig").svelte.setup {
  on_attach = disable_formatting_and_attach,
  capabilities = capabilities,
}

require("lspconfig").tailwindcss.setup {
  on_attach = disable_formatting_and_attach,
  capabilities = capabilities,
  filetypes = { "javascriptreact", "typescriptreact", "html", "css" },
}

require("lspconfig").csharp_ls.setup {
  on_attach = disable_formatting_and_attach,
  capabilities = capabilities,
}

require("lspconfig").prismals.setup {
  on_attach = disable_formatting_and_attach,
  capabilities = capabilities,
  filetypes = {
    "prisma",
  },
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
          [vim.fn.expand "$HOME/.local/share/nvim/site/pack/packer/start"] = true,
        },
      },
    },
  },
  capabilities = capabilities,
}

require("lspconfig").dartls.setup {
  filetype = { "dart" },
  cmd = { "dart", "language-server", "--protocol=lsp" },
  on_attach = function(client, bufnr)
    disable_formatting_and_attach(client, bufnr)
  end,
  capabilities = capabilities,
  init_options = {
    closingLabels = true,
    flutterOutline = true,
    onlyAnalyzeProjectsWithOpenFiles = true,
    outline = true,
    suggestFromUnimportedLibraries = true,
  },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
}
