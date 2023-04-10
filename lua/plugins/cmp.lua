return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    "saadparwaiz1/cmp_luasnip",

    "honza/vim-snippets",
    "rafamadriz/friendly-snippets",
  },
  init = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local lspkind = require "lspkind"

    require("luasnip.loaders.from_snipmate").lazy_load()

    -- local function has_words_before()
    --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    -- end

    cmp.setup {
      formatting = {
        format = lspkind.cmp_format {
          mode = "symbol",
          maxwidth = 50,
          before = function(_, vim_item)
            return vim_item
          end,
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<S-CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
            -- elseif has_words_before() then
            --   cmp.complete()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      },
      sources = cmp.config.sources { { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" } },
    }
  end,
}
