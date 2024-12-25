local menu = require("ui.menu")
local utils = require("utils")

---@type MappingTable
return {
  General = {
    a = {
      {
        desc = "Enter shell command mode",
        lhs = "!",
        rhs = ":!",
        opts = { nowait = true, remap = true },
      },
      {
        desc = "Execute normal mode commands",
        lhs = "<C-n>",
        rhs = ":Norm ",
        opts = { nowait = true },
      },
    },
    n = {
      {
        desc = "Clear highlights",
        lhs = "<Esc>",
        rhs = "<cmd>noh<CR>",
      },
      {
        desc = "Save file",
        lhs = "<C-s>",
        rhs = "<cmd>w<CR>",
      },
      {
        desc = "Toggle nvcheatsheet",
        lhs = "<leader>ch",
        rhs = "<cmd>NvCheatsheet<CR>",
      },
      {
        desc = "Reload highlights",
        lhs = "<leader>rt",
        rhs = require("base46").load_all_highlights,
      },
      {
        desc = "Close Neovim",
        lhs = "<leader>Q",
        rhs = "<cmd>qa<cr>",
      },
      {
        desc = "Edit file",
        lhs = "<leader>n",
        rhs = function()
          utils.prompt_callback("Edit file", "file", function(input)
            vim.cmd("edit " .. input)
          end)
        end,
      },
    },
  },

  Navigation = {
    a = {
      {
        desc = "Move down",
        lhs = "j",
        rhs = 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
        opts = { expr = true },
      },
      {
        desc = "Move up",
        lhs = "k",
        rhs = 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
        opts = { expr = true },
      },
      {
        desc = "Scroll left",
        lhs = "(",
        rhs = utils.global_multiplier() .. "z<Left>",
      },
      {
        desc = "Scroll right",
        lhs = ")",
        rhs = utils.global_multiplier() .. "z<Right>",
      },
      {
        desc = "Scroll down",
        lhs = "<M-n>",
        rhs = "<C-e>",
      },
      {
        desc = "Scroll up",
        lhs = "<M-m>",
        rhs = "<C-y>",
      },
      {
        desc = "Half screen to left",
        lhs = "H",
        rhs = "zH",
      },
      {
        desc = "Half screen to right",
        lhs = "L",
        rhs = "zL",
      },
      {
        desc = "Jump to tag definition under cursor",
        lhs = "gt",
        rhs = "<C-]>",
      },
      {
        desc = "Jump to tag definition under (split window)",
        lhs = "<M-g>t",
        rhs = "<C-W>]",
      },
      {
        desc = "Move to end of line",
        lhs = "<M-l>",
        rhs = "g_",
      },
      {
        desc = "Move to beginning of line",
        lhs = "<M-h>",
        rhs = "^",
      },
      {
        desc = "Move up a few lines",
        lhs = "<M-j>",
        rhs = utils.global_multiplier() .. "j",
        opts = { remap = true },
      },
      {
        desc = "Move down few lines",
        lhs = "<M-k>",
        rhs = utils.global_multiplier() .. "k",
        opts = { remap = true },
      },
    },
  },

  Clipboard = {
    a = {
      {
        desc = "Paste (p)",
        lhs = "<C-p>",
        rhs = '"+p',
      },
      {
        desc = "Paste (P)",
        lhs = "<M-p>",
        rhs = '"+P',
      },
      {
        desc = "Yank",
        lhs = "<C-y>",
        rhs = '"+y',
      },
    },
  },

  Evil = {
    i = {
      {
        desc = "Move left",
        lhs = "<C-b>",
        rhs = "<Left>",
      },
      {
        desc = "Move right",
        lhs = "<C-f>",
        rhs = "<Right>",
      },
      {
        desc = "Move down",
        lhs = "<C-n>",
        rhs = "<Down>",
      },
      {
        desc = "Move up",
        lhs = "<C-p>",
        rhs = "<Up>",
      },
      {
        desc = "Delete next word",
        lhs = "<M-d>",
        rhs = "<Esc>ldei",
      },
      {
        desc = "Delete from cursor to end of line",
        lhs = "<C-k>",
        rhs = "<Esc>lDa",
      },
      {
        desc = "Go to start of the line",
        lhs = "<C-a>",
        rhs = "<Esc>^i",
      },
      {
        desc = "Go to end of the line",
        lhs = "<C-e>",
        rhs = "<End>",
      },
      {
        desc = "Go to previous word",
        lhs = "<M-b>",
        rhs = "<Esc>bi",
      },
      {
        desc = "Go to next word",
        lhs = "<M-f>",
        rhs = "<Esc>lea",
      },
    },
  },

  Buffer = {
    n = {
      {
        desc = "Go to next buffer",
        lhs = "<M-.>",
        rhs = function()
          require("nvchad.tabufline").next()
        end,
      },
      {
        desc = "Go to previous buffer",
        lhs = "<M-,>",
        rhs = function()
          require("nvchad.tabufline").prev()
        end,
      },
      {
        desc = "Close current buffer",
        lhs = "<leader>x",
        rhs = function()
          require("nvchad.tabufline").close_buffer()
        end,
      },
      {
        desc = "Close all other buffers",
        lhs = "<leader>bo",
        rhs = function()
          require("nvchad.tabufline").closeAllBufs(false)
        end,
      },
      {
        desc = "Close all buffers",
        lhs = "<leader>bx",
        rhs = function()
          require("nvchad.tabufline").closeAllBufs(true)
        end,
      },
      {
        desc = "Create a scratch buffer",
        lhs = "<leader>S",
        rhs = function()
          local buf = vim.api.nvim_create_buf(true, true)
          if buf ~= 0 then
            vim.api.nvim_set_current_buf(buf)
          end
        end,
      },
      {
        desc = "Reload buffer",
        lhs = "<leader>br",
        rhs = "<cmd>edit!<cr>",
      },
    },
  },

  Window = {
    n = {
      {
        desc = "Horizontal split",
        lhs = "<M-s>h",
        rhs = "<C-w>s",
      },
      {
        desc = "Vertical split",
        lhs = "<M-s>v",
        rhs = "<C-w>v",
      },
      {
        desc = "Max out window width",
        lhs = "<M-w>w",
        rhs = "<C-w>|",
      },
      {
        desc = "Max out window height",
        lhs = "<M-w>h",
        rhs = "<C-w>_",
      },
      {
        desc = "Close current window",
        lhs = "<C-c>",
        rhs = "<C-w>c",
      },
      {
        desc = "Close all other windows",
        lhs = "<M-c>",
        rhs = "<C-w>o",
      },
      {
        desc = "Increase window height",
        lhs = "<M-=>",
        rhs = utils.global_multiplier(0.5) .. "<C-w>+",
      },
      {
        desc = "Decrease window height",
        lhs = "<M-->",
        rhs = utils.global_multiplier(0.5) .. "<C-w>-",
      },
      {
        desc = "Increase window width",
        lhs = "<M-]>",
        rhs = utils.global_multiplier() .. "<C-w>>",
      },
      {
        desc = "Decrease window width",
        lhs = "<M-[>",
        rhs = utils.global_multiplier() .. "<C-w><",
      },
      {
        desc = "Uniform window size",
        lhs = "<M-w>u",
        rhs = "<C-w>=",
      },
      {
        desc = "Go to previous window",
        lhs = "<M-o>",
        rhs = "<C-w>p",
      },
      {
        desc = "Create new tab",
        lhs = "<M-t>n",
        rhs = "<cmd>tabnew<cr>",
      },
      {
        desc = "Close current tab",
        lhs = "<M-q>",
        rhs = "<cmd>tabclose<cr>",
      },
      {
        desc = "Close all other tabs",
        lhs = "<M-t>o",
        rhs = "<cmd>tabonly<cr>",
      },
      {
        desc = "Go to next tab",
        lhs = "<M-f>",
        rhs = "gt",
      },
      {
        desc = "Go to previous tab",
        lhs = "<M-b>",
        rhs = "gT",
      },
    },
  },

  Shortcuts = {
    n = {
      {
        desc = "Copy current file path",
        lhs = "<leader>y",
        rhs = function()
          local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.fn.bufnr("%")), ":.")
          vim.fn.setreg("+", fname)
        end,
      },
      {
        desc = "Copy current file path and line position",
        lhs = "<leader>Y",
        rhs = function()
          local line = vim.api.nvim_win_get_cursor(0)[1]
          local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.fn.bufnr("%")), ":.")
          vim.fn.setreg("+", fname .. ":" .. line)
        end,
      },
      {
        desc = "Toggle comment line",
        lhs = "<leader>/",
        rhs = "gcc",
        opts = { remap = true },
      },
      {
        desc = "Open color picker",
        lhs = "<leader>cp",
        rhs = "<cmd>Huefy<cr>",
      },
      {
        desc = "Open shades picker",
        lhs = "<leader>cs",
        rhs = "<cmd>Shades<cr>",
      },
    },

    v = {
      {
        desc = "Toggle comment",
        lhs = "<leader>/",
        rhs = "gc",
        opts = { remap = true },
      },
    },
  },

  Toggles = {
    a = {
      {
        desc = "Line wrap",
        lhs = "<leader>tw",
        rhs = function()
          vim.o.wrap = not vim.o.wrap
        end,
      },
    },
    n = {
      {
        desc = "Toggle autoformat on save",
        lhs = "<leader>tf",
        rhs = function()
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          vim.cmd("redrawstatus")
        end,
      },
    },
  },

  LSP = {
    a = {
      {
        desc = "Code action",
        lhs = "<leader>ca",
        rhs = vim.lsp.buf.code_action,
      },
    },

    n = {
      {
        desc = "Show references",
        lhs = "gr",
        rhs = "<cmd>Telescope lsp_references<cr>",
      },
      {
        desc = "Show incoming calls",
        lhs = "gI",
        rhs = "<cmd>Telescope lsp_incoming_calls<cr>",
      },
      {
        desc = "Show outgoing calls",
        lhs = "gO",
        rhs = "<cmd>Telescope lsp_outgoing_calls<cr>",
      },
      {
        desc = "Goto definition",
        lhs = "gd",
        rhs = "<cmd>Telescope lsp_definitions<cr>",
      },
      {
        desc = "Goto type definition",
        lhs = "gD",
        rhs = "<cmd>Telescope lsp_type_definitions<cr>",
      },
      {
        desc = "Goto implementation",
        lhs = "gi",
        rhs = "<cmd>Telescope lsp_implementations<cr>",
      },
      {
        desc = "Show document symbols",
        lhs = "<leader>ls",
        rhs = "<cmd>Telescope lsp_document_symbols<cr>",
      },
      {
        desc = "Show workspace symbols",
        lhs = "<leader>lx",
        rhs = "<cmd>Telescope lsp_workspace_symbols<cr>",
      },
      {
        desc = "Show dynamic workspace symbols",
        lhs = "<leader>lX",
        rhs = "<cmd>Telescope lsp_implementations<cr>",
      },
      {
        desc = "Show diagnostics",
        lhs = "<leader>da",
        rhs = "<cmd>Telescope diagnostics<cr>",
      },
      {
        desc = "Show signature help",
        lhs = "<leader>sh",
        rhs = vim.lsp.buf.signature_help,
      },
      {
        desc = "Add workspace folder",
        lhs = "<leader>wa",
        rhs = vim.lsp.buf.add_workspace_folder,
      },
      {
        desc = "Remove workspace folder",
        lhs = "<leader>wr",
        rhs = vim.lsp.buf.remove_workspace_folder,
      },
      {
        desc = "List workspace folders",
        lhs = "<leader>lf",
        rhs = function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
      },
      {
        desc = "NvRenamer",
        lhs = "<leader>ra",
        rhs = require("nvchad.lsp.renamer"),
      },

      -- Diagnostics
      {
        desc = "Diagnostic loclist",
        lhs = "<leader>dq",
        rhs = vim.diagnostic.setloclist,
      },
      {
        desc = "Toggle diagnostic",
        lhs = "<leader>td",
        rhs = function()
          vim.diagnostic.enable(not vim.diagnostic.is_enabled())
          vim.cmd("redrawstatus")
        end,
      },
      {
        desc = "Floating diagnostic",
        lhs = "<M-d>",
        rhs = function()
          vim.diagnostic.open_float({ border = "rounded" })
        end,
      },
      {
        desc = "Previous diagnostic",
        lhs = "[d",
        rhs = function()
          vim.diagnostic.goto_prev({ float = { border = "rounded" } })
        end,
      },
      {
        desc = "Next diagnostic",
        lhs = "]d",
        rhs = function()
          vim.diagnostic.goto_next({ float = { border = "rounded" } })
        end,
      },
    },
  },

  Lazy = {
    n = {
      {
        desc = "Open menu",
        lhs = "<leader>L",
        rhs = "<cmd>Lazy<cr>",
      },
    },
  },

  Menu = {
    a = {
      {
        desc = "Right-click",
        lhs = "<RightMouse>",
        rhs = function()
          vim.cmd.exec('"normal! \\<RightMouse>"')
          local options = vim.bo.ft == "NvimTree" and "nvimtree" or menu.default
          require("menu").open(options, { mouse = true })
        end,
      },
    },
  },
}
