vim.api.nvim_exec(
  [[
  function OpenMarkdownPreview (url)
    execute "silent ! min " . a:url
  endfunction
]],
  false
)

vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
vim.g.mkdp_port = 1234
vim.g.mkdp_echo_preview_url = 1
