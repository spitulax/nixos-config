--- Search stuff.

local utils = require("utils")

---@type PluginConfig
return {
  spec = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "AckslD/nvim-neoclip.lua",
    },
  },

  mappings = function()
    return {
      Telescope = {
        a = {
          {
            desc = "Preview clipboard",
            lhs = "<leader>v",
            rhs = "<cmd>Telescope neoclip<cr>",
          },
        },
        n = {
          {
            desc = "Resume",
            lhs = "<leader>ff",
            rhs = "<cmd>Telescope resume<cr>",
          },
          {
            desc = "Find files",
            lhs = "<leader>o",
            rhs = "<cmd>Telescope find_files<cr>",
          },
          {
            desc = "Find files in specified directory",
            lhs = "<leader>fe",
            rhs = function()
              utils.prompt_callback("Find files in", "file", function(input)
                vim.cmd("Telescope find_files cwd=" .. input)
              end)
            end,
          },
          {
            desc = "Find buffers",
            lhs = "<C-b>",
            rhs = "<cmd>Telescope buffers<cr>",
          },
          {
            desc = "Telescope Find keybindings",
            lhs = "<leader>fk",
            rhs = "<cmd>Telescope keymaps<cr>",
          },
          {
            desc = "Telescope Builtin commands",
            lhs = "<leader>ft",
            rhs = "<cmd>Telescope builtin<cr>",
          },
          {
            desc = "Telescope Color highlights",
            lhs = "<leader>fc",
            rhs = "<cmd>Telescope highlights<cr>",
          },
          {
            desc = "Telescope Git commits",
            lhs = "<leader>gc",
            rhs = "<cmd>Telescope git_commits<cr>",
          },
          {
            desc = "Telescope Git branches",
            lhs = "<leader>gb",
            rhs = "<cmd>Telescope git_branches<cr>",
          },
          {
            desc = "Telescope Git stash",
            lhs = "<leader>gs",
            rhs = "<cmd>Telescope git_stash<cr>",
          },
          {
            desc = "Telescope Find oldfiles",
            lhs = "<leader>fo",
            rhs = "<cmd>Telescope oldfiles<cr>",
          },
          {
            desc = "Telescope Live grep",
            lhs = "<leader>fw",
            rhs = "<cmd>Telescope live_grep<cr>",
          },
          {
            desc = "Telescope Help page",
            lhs = "<leader>fh",
            rhs = "<cmd>Telescope help_tags<cr>",
          },
          {
            desc = "Telescope NvChad themes",
            lhs = "<leader>tt",
            rhs = "<cmd>Telescope themes<cr>",
          },
          {
            desc = "Find in current buffer",
            lhs = "<leader>fz",
            rhs = "<cmd>Telescope current_buffer_fuzzy_find<cr>",
          },
          {
            desc = "Find all files",
            lhs = "<leader>fa",
            rhs = "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>",
          },
        },
      },
    }
  end,
}
