return {
  "akinsho/bufferline.nvim",
  version = "v2.*",
  dependencies = "kyazdani42/nvim-web-devicons",
  event = "BufEnter",
  opts = {
    options = {
      offsets = {
        { filetype = "NvimTree", text = "", padding = 1 },
        { filetype = "neo-tree", text = "", padding = 1 },
        { filetype = "Outline", text = "", padding = 1 },
      },
      buffer_close_icon = "",
      modified_icon = "",
      close_icon = "",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      separator_style = "thin",
    },
  },
  config = true,
}
