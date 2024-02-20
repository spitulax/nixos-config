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
    ["<tab>"] = "",
    ["<S-tab>"] = "",
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
    ["<leader>rt"] = { function()
      require("base46").load_all_highlights()
    end, "Reload highlights" },
    ["<C-p>"] = { "\"+p", "Paste from + register (p)" },
    ["<M-p>"] = { "\"+P", "Paste from + register (P)" },
    ["<C-y>"] = { "\"+y", "Yank to + register" },
    ["<leader>Q"] = { "<cmd>qa<cr>", "Close Neovim" },
    ["("] = { "zh", "Scroll to left" },
    [")"] = { "zl", "Scroll to right" },

    -- buffer management
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
    ["<leader>x"] = {
      function()
        MiniBufremove.delete(0)
      end,
      "Close current buffer"
    },
    ["<leader>X"] = {
      function()
        MiniBufremove.delete(vim.fn.bufnr('#'))
      end,
      "Close previous buffer"
    },
    ["<leader>bo"] = {
      function()
        for i = 1, vim.fn.bufnr('$') do
          if vim.fn.bufexists(i) == 1 and i ~= vim.fn.bufnr('%') then
            MiniBufremove.delete(i)
          end
        end
      end,
      "Close all other buffers"
    },
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

    -- toggles
    ["<leader>tw"] = {
      function()
        if vim.o.wrap then
          vim.o.wrap = false
        else
          vim.o.wrap = true
        end
      end,
      "Toggle line wrap"
    },
  },

  v = {
    -- shortcuts
    ["!"] = { ":!", "Enter shell command mode", opts = { nowait = true } },
    ["<C-n>"] = { ":Norm ", "Execute normal mode commands", opts = { nowait = true } },
    ["<C-p>"] = { "\"+p", "Paste from + register (p)" },
    ["<C-y>"] = { "\"+y", "Yank to + register" },
  },

  t = {
    ["<C-\\>"] = { "<C-\\><C-n>", "Leave terminal mode", opts = { silent = true, nowait = true } },
    ["<M-c>"] = { "<C-\\><C-n><C-w>q", "Close terminal" , opts = { silent = true, nowait = true } },
  },
}

local mappings = {
  "nvimtree",
  "lspconfig",
  "telescope",
  "harpoon",
  "neogit",
  "icon_picker",
  "nvterm",
  "git_conflict",
  "hop",
  "gitsigns",
  "spectre",
  "todo",
}

for _, plugin in ipairs(mappings) do
  local table = require("custom.configs." .. plugin).mappings
  if table ~= nil then
    M[plugin] = table
  end
end

return M
