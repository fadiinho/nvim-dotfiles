local utils = require "plugins.feline.utils"
local lsp_utils = require "utils.lsp"

local left = {
  utils.get_vi_mode(),
  utils.spacer { bg = utils.colors.cmyk_black },
  utils.spacer {
    spacer = utils.SPACERS.left,
    fg = utils.colors.dark_400,
    bg = utils.colors.cmyk_black,
    enabled = function()
      local check = require("feline.providers.git").git_info_exists()
      if check == nil or check == "" then
        return false
      end
      return true
    end,
  },
  {
    provider = "git_branch",
    hl = { fg = utils.colors.hot_pink, bg = utils.colors.dark_400, style = "bold" },
  },
  utils.spacer {
    spacer = utils.SPACERS.right,
    fg = utils.colors.dark_400,
    bg = utils.colors.cmyk_black,
    enabled = function()
      local check = require("feline.providers.git").git_info_exists()
      if check == nil or check == "" then
        return false
      end
      return true
    end,
  },
  {
    provider = "git_diff_added",
    hl = { fg = utils.colors.grrreen, bg = utils.colors.cmyk_black },
    icon = "  ",
  },
  {
    provider = "git_diff_changed",
    hl = { fg = utils.colors.tangerrrine, bg = utils.colors.cmyk_black },
    icon = " 柳",
  },
  {
    provider = "git_diff_removed",
    hl = { fg = utils.colors.electric_crrrimson, bg = utils.colors.cmyk_black },
    icon = "  ",
  },
  utils.spacer { bg = utils.colors.cmyk_black },
}

local _utils = require "cmyk-colourrrs.utils"

local middle = {
  { " " },
  utils.spacer {
    spacer = utils.SPACERS.left,
    fg = utils.colors.dark_400,
    bg = utils.colors.cmyk_black,
    enabled = function()
      return _utils.tbl_diagnostics_exists { "warn", "info", "hint", "error" }
    end,
  },
  {
    provider = "diagnostic_errors",
    hl = function()
      return { fg = _utils.hl_by_name("DiagnosticError", "foreground"), bg = utils.colors.dark_400 }
    end,
  },
  {
    provider = "diagnostic_warnings",
    hl = function()
      return { fg = _utils.hl_by_name("DiagnosticWarn", "foreground"), bg = utils.colors.dark_400 }
    end,
  },
  {
    provider = "diagnostic_hints",
    hl = function()
      return { fg = _utils.hl_by_name("DiagnosticHint", "foreground"), bg = utils.colors.dark_400 }
    end,
  },
  {
    provider = "diagnostic_info",
    hl = function()
      return { fg = _utils.hl_by_name("DiagnosticInfo", "foreground"), bg = utils.colors.dark_400 }
    end,
  },
  utils.spacer {
    spacer = utils.SPACERS.right,
    fg = utils.colors.dark_400,
    bg = utils.colors.cmyk_black,
    enabled = function()
      return _utils.tbl_diagnostics_exists { "warn", "info", "hint", "error" }
    end,
  },
  { " " },
  {
    provider = function()
      return lsp_utils.lsp_progress()
    end,
    left_sep = " ",
  },
}

local right = {
  {
    provider = lsp_utils.lsp_client_names(true),
    hl = "StatusLine",
    icon = "   ",
  },
  utils.spacer(),
  {
    provider = {
      name = "file_type",
      opts = {
        filetype_icon = true,
        case = "lowercase",
      },
    },
    hl = { fg = utils.colors.light_100, bg = utils.colors.cmyk_black },
    left_sep = " ",
  },
  utils.spacer(),
  {
    provider = "line_percentage",
    hl = { fg = utils.colors.light_100, bg = utils.colors.cmyk_black },
    left_sep = " ",
  },
  utils.spacer { bg = utils.colors.cmyk_black },
  utils.spacer(),
  {
    provider = function()
      return os.date "%H:%M"
    end,
    left_sep = " ",
  },
  utils.spacer { bg = utils.colors.cmyk_black },
  utils.get_vi_mode(),
}

local components = {
  active = {
    left,
    middle,
    right,
  },
}

return components
