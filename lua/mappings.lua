local utils = require "utils"

local maps = { n = {}, v = {}, t = {} }

-- :)
maps.n["<leader>w"] = {
  ":w<cr>",
  { desc = "Save buffer" },
}

maps.n["<leader>q"] = {
  ":q<cr>",
  { desc = "Quit buffer" },
}

maps.n["<C-a>"] = {
  "gg<S-v>G",
  { desc = "Select all buffer" },
}

maps.n["<leader>d"] = {
  '"_d',
  { desc = "Delete things and send to void register" },
}

maps.v["<leader>d"] = {
  '"_d',
  { desc = "Delete things and send to void register" },
}

maps.n["<leader>j"] = {
  utils.next_color_scheme,
  { desc = "Change to next colorscheme" },
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

-- Telescope
maps.n["<leader>fw"] = {
  function()
    require("telescope.builtin").live_grep()
  end,
  desc = "Search words",
}
maps.n["<leader>fW"] = {
  function()
    require("telescope.builtin").live_grep {
      additional_args = function(args)
        return vim.list_extend(args, { "--hidden", "--no-ignore" })
      end,
    }
  end,
  desc = "Search words in all files",
}
maps.n["<leader>gt"] = {
  function()
    require("telescope.builtin").git_status()
  end,
  desc = "Git status",
}
maps.n["<leader>gb"] = {
  function()
    require("telescope.builtin").git_branches()
  end,
  desc = "Git branches",
}
maps.n["<leader>gc"] = {
  function()
    require("telescope.builtin").git_commits()
  end,
  desc = "Git commits",
}
maps.n["<leader>ff"] = {
  function()
    require("telescope.builtin").find_files()
  end,
  desc = "Search files",
}
maps.n["<leader>fF"] = {
  function()
    require("telescope.builtin").find_files { hidden = true, no_ignore = true }
  end,
  desc = "Search all files",
}
maps.n["<leader>fb"] = {
  function()
    require("telescope.builtin").buffers()
  end,
  desc = "Search buffers",
}
maps.n["<leader>fm"] = {
  function()
    require("telescope.builtin").marks()
  end,
  desc = "Search marks",
}
maps.n["<leader>fo"] = {
  function()
    require("telescope.builtin").oldfiles()
  end,
  desc = "Search history",
}
maps.n["<leader>fc"] = {
  function()
    require("telescope.builtin").grep_string()
  end,
  desc = "Search for word under cursor",
}
maps.n["<leader>sb"] = {
  function()
    require("telescope.builtin").git_branches()
  end,
  desc = "Git branches",
}
maps.n["<leader>sh"] = {
  function()
    require("telescope.builtin").help_tags()
  end,
  desc = "Search help",
}
maps.n["<leader>sm"] = {
  function()
    require("telescope.builtin").man_pages()
  end,
  desc = "Search man",
}
maps.n["<leader>sr"] = {
  function()
    require("telescope.builtin").registers()
  end,
  desc = "Search registers",
}
maps.n["<leader>sk"] = {
  function()
    require("telescope.builtin").keymaps()
  end,
  desc = "Search keymaps",
}
maps.n["<leader>sc"] = {
  function()
    require("telescope.builtin").commands()
  end,
  desc = "Search commands",
}
maps.n["<leader>lR"] = {
  function()
    require("telescope.builtin").lsp_references()
  end,
  desc = "Search references",
}
maps.n["<leader>lD"] = {
  function()
    require("telescope.builtin").diagnostics()
  end,
  desc = "Search diagnostics",
}

utils.set_keymaps(maps)
