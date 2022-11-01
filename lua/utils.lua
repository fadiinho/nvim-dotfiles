local api = vim.api

local M = {}

M.set_keymaps = function(maps)
  for mode, _maps in pairs(maps) do
    for key, values in pairs(_maps) do
      vim.keymap.set(mode, key, values[1], values[2])
    end
  end
end

M.get_selection = function()
  local selectionStart = vim.fn.line "v"
  local selectionEnd = vim.fn.line "."

  if selectionStart > selectionEnd then
    local temp = selectionStart
    selectionStart = selectionEnd
    selectionEnd = temp
  end

  local lines = api.nvim_buf_get_lines(0, selectionStart - 1, selectionEnd, true)

  return { lines, selectionStart, selectionEnd }
end

M.insert_lines_down_v = function()
  local selection = M.get_selection()
  local bufLines = api.nvim_buf_line_count(0)

  local buf = api.nvim_buf_get_lines(0, selection[3], bufLines, true)

  for i = #selection[1], 1, -1 do
    local value = selection[1][i]
    table.insert(buf, 1, value)
  end

  if buf[1] ~= "" then
    table.insert(buf, 1, "")
  end

  api.nvim_buf_set_lines(0, selection[3], bufLines, true, buf)
  api.nvim_feedkeys(api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end

M.insert_lines_up_v = function()
  local selection = M.get_selection()

  local buf = api.nvim_buf_get_lines(0, 0, selection[2], true)

  local count = 0
  for i = #selection[1], 1, -1 do
    local value = selection[1][i]
    count = count + 1
    table.insert(buf, selection[2], value)
  end

  api.nvim_buf_set_lines(0, 0, selection[2], true, buf)
  api.nvim_feedkeys(api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end

M.insert_lines_down_n = function()
  local cursorLine = api.nvim_win_get_cursor(0)

  local buf = api.nvim_buf_get_lines(0, cursorLine[1] - 1, cursorLine[1], true)

  api.nvim_buf_set_lines(0, cursorLine[1], cursorLine[1], true, buf)
  api.nvim_win_set_cursor(0, { cursorLine[1] + 1, cursorLine[2] }) -- Set the cursor to the right position
end

M.insert_lines_up_n = function()
  local cursor = api.nvim_win_get_cursor(0)[1]

  local buf = api.nvim_buf_get_lines(0, cursor - 1, cursor, true)

  table.insert(buf, 2, buf[1])

  api.nvim_buf_set_lines(0, cursor - 1, cursor, true, buf)
end

M.swap_lines = function(up_or_down)
  local cursor = api.nvim_win_get_cursor(0) -- Current cursor position

  local options = {} --  I don't have a better name
  if up_or_down == 1 then
    options = { cursor[1] - 2, cursor[1] - 1 } -- Swap current line up
  else
    options = { cursor[1], cursor[1] + 1 } -- Swap current line down
  end

  if options[1] < 0 or options[2] > vim.api.nvim_buf_line_count(vim.api.nvim_win_get_buf(0)) then
    return
  end

  local currentLine = api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true) -- Get the current cursor line

  local nextLine = api.nvim_buf_get_lines(0, options[1], options[2], true) -- Get the line we want to swap

  api.nvim_buf_set_lines(0, cursor[1] - 1, cursor[1], true, nextLine) -- Set the current line to the line that we want to swap
  api.nvim_buf_set_lines(0, options[1], options[2], true, currentLine) -- Set the line that we want to swap to the current line

  api.nvim_win_set_cursor(0, { options[1] + 1, options[2] }) -- Set the cursor to the swapped position
end

M.find_bin_location = function(cmd)
  local currentDirectoryPwd = os.getenv "PWD"

  local function search(path)
    local commandAndPath = "fd -tx " .. cmd .. " " .. path
    local yarnCommand = commandAndPath .. "/.yarn/unplugged 2>/dev/null"
    local nodeModulesCommand = commandAndPath .. "/node_modules 2>/dev/null"

    local command = io.popen(nodeModulesCommand)

    local filenames = {}

    if not command then
      return nil
    end

    for filename in command:lines() do
      table.insert(filenames, filename)
    end

    if vim.tbl_isempty(filenames) then
      command = io.popen(yarnCommand)

      if not command then
        return nil
      end
    end

    for filename in command:lines() do
      table.insert(filenames, filename)
    end

    if vim.tbl_isempty(filenames) then
      return nil
    end

    return filenames
  end

  local result = search(currentDirectoryPwd)

  if not result then
    return nil
  end

  return result[1]
end

M.moveCursor = function(key)
  api.nvim_feedkeys(api.nvim_replace_termcodes(key, true, false, true), "n", false)
end

M.format = function()
  vim.lsp.buf.formatting_sync()
end

M.tbl_get_index = function(_table, value)
  for i, v in ipairs(_table) do
    if v == value then
      return i
    end
  end

  return nil
end

M.next_color_scheme = function()
  local themes = require "themes"
  local value = M.tbl_get_index(themes, vim.g.colors_name)
  vim.cmd("colorscheme " .. themes[value + 1])
end

-- Source: Astronvim
M.null_ls_providers = function(filetype)
  local registered = {}
  -- try to load null-ls
  local sources_avail, sources = pcall(require, "null-ls.sources")
  if sources_avail then
    -- get the available sources of a given filetype
    for _, source in ipairs(sources.get_available(filetype)) do
      -- get each source name
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        table.insert(registered[method], source.name)
      end
    end
  end
  -- return the found null-ls sources
  return registered
end

-- Source: Astronvim
M.null_ls_sources = function(filetype, method)
  local methods_avail, methods = pcall(require, "null-ls.methods")
  return methods_avail and M.null_ls_providers(filetype)[methods.internal[method]] or {}
end

M.SPACERS = {
  left = "",
  mid = "▊",
  right = "",
}

M.spacer = function(props)
  props = vim.tbl_deep_extend("force", {
    fg = "NONE",
    bg = "NONE",
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

local function _hl_by_name(name)
  return vim.api.nvim_get_hl_by_name(name, true)
end

M.hl_by_name = function(name, prop)
  return string.format("#%06x", _hl_by_name(name)[prop])
end

M.diagnostic_exists = function(_diagnostic)
  local diagnostics = {
    ERROR = 1,
    WARN = 2,
    INFO = 3,
    HINT = 4,
  }

  local diagnostic = diagnostics[string.upper(_diagnostic)]

  if not diagnostic then
    return false
  end

  for _, v in ipairs(vim.diagnostic.get(0)) do
    if diagnostic == v.severity then
      return true
    end
  end

  return false
end

M.tbl_diagnostics_exists = function(diagnostics)
  local exists = false
  for _, v in ipairs(diagnostics) do
    exists = M.diagnostic_exists(v) or exists
  end

  return exists
end

return M
