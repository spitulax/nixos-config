---@type MappingsTable
local M = {}

local function prompt_callback(prompt, completion, callback)
  vim.ui.input({prompt = prompt .. ": ", completion = completion}, function(input)
    if input and string.gsub(input, " ", "") ~= "" then callback(input) end
  end)
end

M.disabled = {
  i = {
    ["<C-e>"] = "",
  },

  n = {
    ["<leader>v"] = "",
    ["<leader>h"] = "",
    ["<leader>n"] = "",
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["<leader>pt"] = "",
    ["<leader>th"] = "",
    ["<leader>rn"] = "",
    ["<C-n>"] = "",
  },
}

M.general = {
  i = {
    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
    ["<C-b>"] = { "<Esc>^i", "Go to start of the line" },
    ["<C-e>"] = { "<End>", "Go to end of the line" },
    ["<M-n>"] = { "<Esc>ea", "Go to end of the word" },
    ["<M-p>"] = { "<Esc>gea", "Go to end of the previous word" },
    ["<M-b>"] = { "<Esc>bi", "Go to beginning of the word" },
  },

  n = {
    -- shortcuts
    ["!"] = { ":!", "Enter shell command mode", opts = { nowait = true } },
    ["<C-p>"] = { "\"+p", "Paste from + register (p)" },
    ["<M-p>"] = { "\"+P", "Paste from + register (P)" },
    ["<C-y>"] = { "\"+y", "Yank to + register" },
    ["<leader>Q"] = { "<cmd>qa<cr>", "Close Neovim" },
    ["<M-.>"] = { "<cmd>bn<cr>", "Goto next buffer" },
    ["<M-,>"] = { "<cmd>bp<cr>", "Goto prev buffer" },
    ["<leader>O"] = {
      function()
        prompt_callback("Change to", "file", function(input)
          vim.cmd("e " .. input)
          if #(vim.fn.win_findbuf(vim.fn.bufnr("#"))) < 1 then
            MiniBufremove.delete(vim.fn.bufnr("#"))
          end
        end)
      end,
      "Change buffer" },
    ["<leader>x"] = { "<cmd>lua MiniBufremove.delete(0)<cr>", "Close current buffer", opts = { silent = true } },
    ["<leader>X"] = { "<cmd>lua MiniBufremove.delete(vim.fn.bufnr('#'))<cr>", "Close previous buffer", opts = { silent = true } },
    ["<leader>S"] = {
      function()
        local buf = vim.api.nvim_create_buf(true, true)
        if buf ~= 0 then vim.api.nvim_set_current_buf(buf) end
      end,
      "Create a scrath buffer",
    },

    -- window and tab management
    ["<M-w>"] = { "<C-w>|", "Max out window width" },
    ["<M-h>"] = { "<C-w>_", "Max out window height" },
    ["<C-c>"] = { "<C-w>q", "Close current window" },
    ["<M-c>"] = { "<C-w>o", "Close all other windows" },
    ["<M-=>"] = { "<C-w>+", "Increase window height" },
    ["<M-->"] = { "<C-w>-", "Decrease window height" },
    ["<M-]>"] = { "<C-w>>", "Increase window width" },
    ["<M-[>"] = { "<C-w><", "Decrease window width" },
    ["<M-e>"] = { "<C-w>=", "Uniform window size" },
    ["<M-t>"] = { "<cmd>tabnew<cr>", "Create new tab" },
    ["<M-q>"] = { "<cmd>tabclose<cr>", "Close current tab" },
    ["<M-a>"] = { "<cmd>tabonly<cr>", "Close all other tabs" },
  },

  v = {
    -- shortcuts
    ["!"] = { ":!", "Enter shell command mode", opts = { nowait = true } },
    ["<C-n>"] = { ":Norm ", "Execute normal mode commands", opts = { nowait = true } },
    ["<C-p>"] = { "\"+p", "Paste from + register (p)" },
    ["<C-y>"] = { "\"+y", "Yank to + register" },
  },
}

M.nvimtree = {
  n = {
    ["<leader>t"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

M.lspconfig = {
  n = {
    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev diagnostic",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next diagnostic",
    },
  },
}

M.telescope = {
  plugin = true,
  n = {
    ["<leader>tr"] = { "<cmd> Telescope resume <CR>", "Resume Telescope" },
    -- find
    ["<leader>fe"] = {
      function()
        prompt_callback("Find files in", "file", function(input)
          vim.cmd("Telescope find_files cwd=" .. input)
        end)
      end,
      "Find files in specified directory",
    },
    ["<leader>o"]   = { "<cmd> Telescope find_files <CR>", "Find files in cwd" },
    ["<M-b>"]       = { "<cmd> Telescope buffers <CR>", "Find opened buffers" },
    ["<leader>fk"]  = { "<cmd> Telescope keymaps <CR>", "Find assigned keybindings" },
    ["<leader>ft"]  = { "<cmd> Telescope builtin <CR>", "Find Telescope builtin commands" },
    ["<leader>fc"]  = { "<cmd> Telescope highlights <CR>", "List highlight groups" },
    ["<leader>fM"]  = { "<cmd> Telescope man_pages <CR>", "Find man pages" },
    -- git
    ["<leader>gc"]  = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gb"]  = { "<cmd> Telescope git_branches <CR>", "Git branches" },
    ["<leader>gs"]  = { "<cmd> Telescope git_stash <CR>", "Git stash" },
    -- extensions
    ["<leader>fxm"] = { "<cmd> Telescope media_files <CR>", "Preview media" },
    ["<leader>fl"]  = { "<cmd> Telescope neoclip <CR>", "Preview clipboard" },
    ["<leader>fp"] = { "<cmd> Telescope projects <CR>", "Project list" },
  },
}

M.harpoon = {
  plugin = true,
  n = {
    ["<leader>h"] = {
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, "Open harpoon window" },
    ["<leader>a"] = { function() require("harpoon"):list():append() end, "Add buffer to harpoon list" },
    ["<leader>p"] = { function() require("harpoon"):list():prev() end, "Jump to previous buffer in harpoon list" },
    ["<leader>n"] = { function() require("harpoon"):list():next() end, "Jump to next buffer in harpoon list" },
    ["<leader>cl"] = { function() require("harpoon"):list():clear() end, "Clear harpoon list" },
  }
}

M.neogit = {
  plugin = true,
  n = {
    ["<leader>g"] = { "<cmd>Neogit<cr>", "Open Neogit" },
  },
}

M.icon_picker = {
  plugin = true,
  n = {
    ["<leader>i"] = { "<cmd>IconPickerYank<cr>", "Open icon picker" },
  },
  i = {
    ["<C-a>"] = { "<cmd>IconPickerInsert<cr>", "Insert an icon" },
  },
}

M.nvterm = {
  plugin = true,
  n = {
    ["<leader>T"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },
    ["<leader>TH"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },
    ["<leader>TV"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },
  t = {
    ["<leader>T"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },
    ["<leader>TH"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },
    ["<leader>TV"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },
}

M.git_conflict = {
  plugin = true,
  n = {
    ["<leader>Co"] = { "<Plug>(git-conflict-ours)", "Choose ours" },
    ["<leader>Ct"] = { "<Plug>(git-conflict-theirs)", "Choose theirs" },
    ["<leader>Cb"] = { "<Plug>(git-conflict-both)", "Choose both" },
    ["<leader>C0"] = { "<Plug>(git-conflict-none)", "Choose none" },
    ["<leader>Cp"] = { "<Plug>(git-conflict-prev-conflict)", "Move to previous conflict" },
    ["<leader>Cn"] = { "<Plug>(git-conflict-next-conflict)", "Move to next conflict" },
  },
}

M.hop = {
  plugin = true,
  n = {
    ["<Tab>"] = { "<cmd>HopWord<cr>", "Hop word" },
    ["<Tab>c"] = { "<cmd>HopChar1<cr>", "Hop one char" },
    ["<Tab>C"] = { "<cmd>HopChar2<cr>", "Hop two chars" },
    ["<Tab>/"] = { "<cmd>HopPattern<cr>", "Hop search pattern" },
    ["<Tab>l"] = { "<cmd>HopLineStart<cr>", "Hop line start" },
    ["<Tab>L"] = { "<cmd>HopLine<cr>", "Hop line" },
  },
}

M.gitsigns = {
  plugin = true,
  n = {
    ["<leader>B"] = { "<cmd>Gitsigns blame_line<CR>", "Blame line" },
    ["<leader>tb"] = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle current line blame" },
  }
}

return M
