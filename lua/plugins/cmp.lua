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
  lazy = false,
  init = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local icons = require "lua.utils.icons"
    if cmp == nil then
      return
    end

    require("luasnip.loaders.from_snipmate").lazy_load()

    cmp.setup {
      formatting = {
        format = function(_, item)
          if icons[item.kind] then
            item.kind = icons[item.kind]
          end

          return item
        end,
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
