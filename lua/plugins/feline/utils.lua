local M = {}

M.SPACERS = {
  left = "",
  mid = "▊",
  right = "",
}

local light_100 = "#E0DDE5"
local dark_100 = "#221B32"

M.colors = {
  cmyk_black = "#130E0F",
  bg = dark_100,
  dark_200 = "#2B223F",
  dark_300 = "#382C51",
  dark_400 = "#302546",
  dark_500 = "#463767",
  purrrple = "#7515EF",
  lavendrrr = "#B596F8",
  cerrrulean = "#15AEEF",
  electric_crrrimson = "#EF1563",
  tangerrrine = "#EF9815",
  highlighterrr_yellow = "#EBEF15",
  grrreen = "#15EFAE",
  grrreen_1 = "#00CC8F",
  hot_pink = "#EF15BF",
  fg = light_100,
  light_200 = "#D5D2DC",
  light_300 = "#BCB9C2",
  light_400 = "#807694",
  light_500 = "#878292",
  bright_white = "#FFFFFF",
}

local modes = {
  ["n"] = { "NORMAL", "Normal", M.colors.grrreen },
  ["no"] = { "N-PENDING", "Normal", M.colors.grrreen },
  ["i"] = { "INSERT", "Insert", M.colors.hot_pink },
  ["ic"] = { "INSERT", "Insert", M.colors.hot_pink },
  ["t"] = { "TERMINAL", "Insert", M.colors.hot_pink },
  ["v"] = { "VISUAL", "Visual", M.colors.cerrrulean },
  ["V"] = { "V-LINE", "Visual", M.colors.cerrrulean },
  [""] = { "V-BLOCK", "Visual", M.colors.cerrrulean },
  ["R"] = { "REPLACE", "Replace", M.colors.electric_crrrimson },
  ["Rv"] = { "V-REPLACE", "Replace", M.colors.electric_crrrimson },
  ["s"] = { "SELECT", "Visual", M.colors.cerrrulean },
  ["S"] = { "S-LINE", "Visual", M.colors.cerrrulean },
  [""] = { "S-BLOCK", "Visual", M.colors.cerrrulean },
  ["c"] = { "COMMAND", "Command", M.colors.purrrple },
  ["cv"] = { "COMMAND", "Command", M.colors.purrrple },
  ["ce"] = { "COMMAND", "Command", M.colors.purrrple },
  ["r"] = { "PROMPT", "Inactive", M.colors.light_500 },
  ["rm"] = { "MORE", "Inactive", M.colors.light_500 },
  ["r?"] = { "CONFIRM", "Inactive", M.colors.light_500 },
  ["!"] = { "SHELL", "Inactive", M.colors.light_500 },
}

M.get_vi_mode = function()
  return {
    provider = function()
      local current_text = " "
      return current_text
    end,
    hl = function()
      local mode_color = modes[vim.fn.mode()][3]
      return {
        fg = M.colors.cmyk_black,
        bg = mode_color,
        style = "bold",
      }
    end,
  }
end

M.spacer = function(props)
  props = vim.tbl_deep_extend("force", {
    fg = M.colors.cmyk_black,
    bg = M.colors.dark_400,
    length = 1,
    spacer = M.SPACERS.mid,
    enabled = true,
    style = "NONE",
  }, props or {})

  local separator = string.rep(props.spacer, props.length)

  return {
    provider = separator,
    hl = {
      fg = props.fg,
      bg = props.bg,
      style = props.style,
    },
    enabled = props.enabled,
  }
end

return M
