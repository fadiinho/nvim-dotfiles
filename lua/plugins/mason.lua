return {
  "williamboman/mason.nvim",
  init = function()
    require("mason").setup {
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    }
  end,
}
