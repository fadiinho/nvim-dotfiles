return {
  "iamcco/markdown-preview.nvim",
  -- event = "VeryLazy",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    vim.api.nvim_exec(
      [[
        function OpenMarkdownPreview (url)
          execute "silent ! opera " . a:url
        endfunction
      ]],
      false
    )
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    vim.g.mkdp_port = 1234
    vim.g.mkdp_echo_preview_url = 1
  end,
}
