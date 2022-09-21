local utils = require "utils"

local maps = { n = {}, v = {}, t = {} }

maps.n["<leader>w"] = {
  ":w<cr>",
  { desc = "Save buffer" },
}

maps.n["<leader>q"] = {
  ":q<cr>",
  { desc = "Quit buffer" },
}

-- Duplicate lines

maps.v["<a-d>k"] = {
  utils.insert_lines_up_v,
  { desc = "Duplicate selection up" },
}

maps.v["<a-d>j"] = {
  utils.insert_lines_down_v,
  { desc = "Duplicate selection down" },
}

maps.n["<a-d>k"] = {
  utils.insert_lines_up_n,
  { desc = "Duplicate line up" },
}

maps.n["<a-d>j"] = {
  utils.insert_lines_down_n,
  { desc = "Duplicate line down" },
}

-- Swap lines

maps.n["<a-k>"] = {
  function()
    utils.swap_lines(1)
  end, -- UP
  { desc = "Swap current line with the line above" },
}

maps.n["<a-j>"] = {
  function()
    utils.swap_lines(2)
  end, -- DOWN
  { desc = "Swap current line with the line below" },
}

-- Indentation
maps.n["<S-l>"] = { ":> <cr>", { desc = "indent line" } }
maps.n["<S-h>"] = { ":< <cr>", { desc = "unindent line" } }

maps.v["<S-l>"] = { ">gv", { desc = "indent line" } }
maps.v["<S-h>"] = { "<gv", { desc = "unindent line" } }

-- Neotree
maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" } }
maps.n["<leader>o"] = { "<cmd>Neotree focus<cr>", { desc = "Focus Explorer" } }

-- Bufferline
maps.n["<A-h>"] = { "<cmd>BufferLineCyclePrev<cr>", { desc = "Cycle to prev buffer" } }
maps.n["<A-l>"] = { "<cmd>BufferLineCycleNext<cr>", { desc = "Cycle to next buffer" } }

-- Delete buffer
maps.n["<leader>c"] = { "<cmd>bdelete<cr>", { desc = "Close buffer" } }

-- Toggleterm
maps.t["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" }

-- Commenting
maps.n["<leader>/"] = {
  function()
    require("Comment.api").toggle.linewise.current()
  end,
  { desc = "Comment line" },
}
maps.v["<leader>/"] = {
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
  { desc = "Toggle comment line" },
}

utils.set_keymaps(maps)
