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

return M
