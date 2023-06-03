return {
  "akinsho/git-conflict.nvim",
  version = "*",
  init = function()
    local git_conflict = require "git-conflict"

    git_conflict.setup {
      default_mappings = true, -- disable buffer local mapping created by this plugin
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = "DiffAdd",
        current = "DiffText",
      },
    }
  end,
}
