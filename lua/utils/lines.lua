local M = {}

local api = vim.api

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

return M
