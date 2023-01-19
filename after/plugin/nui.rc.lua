local utils = require "utils.init"
local Input = require "nui.input"

local text = "[Enter text to replace]"

local input_options = {
  position = "50%",
  size = {
    width = string.len(text),
  },
  border = {
    style = "single",
    text = {
      top = text,
      top_align = "center",
    },
  },
  win_options = {
    winhighlight = "Normal:Normal,FloatBorder:Normal",
  },
}

local input = Input(input_options, {
  prompt = "> ",
  on_submit = function(value)
    -- local wordUnderCursor = vim.fn.expand "<cword>"
    utils.replace(value)
  end,
})

local function toggle()
  if input._.mounted then
    input:unmount()
    return
  end

  input:mount()
end

local map = { n = {}, v = {} }

map.n["<leader>wr"] = {
  toggle,
  { desc = "Toggle this ui" },
}

map.v["<leader>wr"] = {
  toggle,
  { desc = "Toggle this ui" },
}

utils.set_keymaps(map)
