local M = {}

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

M.diagnostic_exists = function(_diagnostic)
  local diagnostics = {
    ERROR = 2,
    WARN = 3,
    INFO = 4,
    HINT = 5,
  }

  local diagnostic = diagnostics[string.upper(_diagnostic)]

  if not diagnostic then
    return false
  end

  for _, v in ipairs(vim.diagnostic.get(1)) do
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

-- Source: https://github.com/AstroNvim/AstroNvim/blob/main/lua/core/status.lua
M.lsp_client_names = function(expand_null_ls)
  return function()
    local buf_client_names = {}
    for _, client in pairs(vim.lsp.buf_get_clients(0)) do
      if client.name == "null-ls" and expand_null_ls then
        vim.list_extend(buf_client_names, M.null_ls_sources(vim.bo.filetype, "FORMATTING"))
        vim.list_extend(buf_client_names, M.null_ls_sources(vim.bo.filetype, "DIAGNOSTICS"))
      else
        table.insert(buf_client_names, client.name)
      end
    end
    return table.concat(buf_client_names, ", ")
  end
end

-- Source: https://github.com/AstroNvim/AstroNvim/blob/main/lua/core/status.lua

M.lsp_progress = function()
  if #vim.lsp.buf_get_clients() == 0 then
    return ""
  end

  local lsp = vim.lsp.util.get_progress_messages()[1]
  if lsp then
    local name = lsp.name or ""
    local msg = lsp.message or ""
    local percentage = lsp.percentage or 0
    local title = lsp.title or ""
    return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
  end
  return ""
end

return M
