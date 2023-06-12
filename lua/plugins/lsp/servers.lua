local utils = require "plugins.lsp.utils"

local servers = {
  lua_ls = {
    on_attach = utils.on_attach_no_format,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            [vim.fn.expand "$HOME/.local/share/nvim/lazy"] = true,
          },
        },
      },
    },
    capabilities = utils.capabilities,
  },

  pyright = {
    on_attach = utils.on_attach_no_format,
    capabilities = utils.capabilities,
  },

  tsserver = {
    on_attach = utils.on_attach_no_format,
    filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
    cmd = { "typescript-language-server", "--stdio" },
    capabilities = utils.capabilities,
  },

  rust_analyzer = {
    on_attach = utils.on_attach_no_format,
    capabilities = utils.capabilities,
    settings = {
      ["rust-analyzer"] = {
        diagnostics = {
          disabled = { "unresolved-proc-macro" },
        },
      },
    },
  },

  html = {
    on_attach = utils.disable_formatting_and_attach,
    provideFormatter = false,
    capabilities = utils.capabilities,
  },

  cssls = {
    on_attach = utils.disable_formatting_and_attach,
    capabilities = utils.capabilities,
  },

  svelte = {
    on_attach = utils.disable_formatting_and_attach,
    capabilities = utils.capabilities,
  },

  tailwindcss = {
    on_attach = utils.disable_formatting_and_attach,
    capabilities = utils.capabilities,
    filetypes = { "javascriptreact", "typescriptreact", "html", "css" },
  },

  csharp_ls = {
    on_attach = utils.disable_formatting_and_attach,
    capabilities = utils.capabilities,
  },

  prismals = {
    on_attach = utils.disable_formatting_and_attach,
    capabilities = utils.capabilities,
    filetypes = {
      "prisma",
    },
  },

  dartls = {
    filetype = { "dart" },
    cmd = { "dart", "language-server", "--protocol=lsp" },
    on_attach = utils.on_attach_no_format,
    capabilities = utils.capabilities,
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
  },

  clangd = {
    on_attach = utils.on_attach_no_format,
    capabilities = utils.capabilities,
  },

  volar = {
    on_attach = utils.on_attach_no_format,
    capabilities = utils.capabilities,
  },

  bashls = {
    on_attach = utils.on_attach_no_format,
    capabilities = utils.capabilities,
  },
}

return servers
