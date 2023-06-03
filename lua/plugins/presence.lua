return {
  "andweeb/presence.nvim",
  init = function()
    local presence = require "presence"

    local utils = require "utils"

    presence:setup {
      -- General options
      auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
      neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
      main_image = "neovim", -- Main image display (either "neovim" or "file")
      client_id = "793271441293967371", -- Use your own Discord application client id (not recommended)
      log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
      debounce_timeout = 1, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
      enable_line_number = true, -- Displays the current line number instead of the current project
      blacklist = { ".*%.tmp" }, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
      buttons = function(_, repo_url)
        local _buttons = {}

        table.insert(_buttons, { label = "My Github", url = "https://github.com/fadiinho" })

        local shouldAddUrl = utils.has_file ".repo_presence_ignore"

        if repo_url and not shouldAddUrl then
          table.insert(_buttons, { label = "Take a look at this repo", url = utils.git_ssh_to_url(repo_url) })
        else
          table.insert(_buttons, { label = "Don't click here shhhh", url = "http://pudim.com.br" })
        end

        return _buttons
      end,
      file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
      show_time = true, -- Show the timer

      -- Rich Presence text options
      editing_text = "Editando %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
      file_explorer_text = "Navegando %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
      reading_text = "Lendo %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
      workspace_text = "Trabalhando em %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
      line_number_text = "Linha %s de %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    }
  end,
}
