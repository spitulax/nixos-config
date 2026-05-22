--- Search stuff.

local utils = require("utils")

---@type PluginConfig
return {
  spec = {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "AckslD/nvim-neoclip.lua",
    },
  },

  opts = function()
    return {
      defaults = {
        previewer = false,
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            anchor = "S",
            prompt_position = "top",
            preview_width = 0.4,
          },
          height = 0.6,
          width = 0.999,
        },
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
        },
      },

      extensions = {},
    }
  end,

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
            desc = "Find keybindings",
            lhs = "<leader>fk",
            rhs = "<cmd>Telescope keymaps<cr>",
          },
          {
            desc = "Builtin commands",
            lhs = "<leader>ft",
            rhs = "<cmd>Telescope builtin<cr>",
          },
          {
            desc = "Color highlights",
            lhs = "<leader>fc",
            rhs = "<cmd>Telescope highlights<cr>",
          },
          {
            desc = "Find oldfiles",
            lhs = "<leader>fo",
            rhs = "<cmd>Telescope oldfiles<cr>",
          },
          {
            desc = "Live grep",
            lhs = "<leader>fw",
            rhs = "<cmd>Telescope live_grep<cr>",
          },
          {
            desc = "Help page",
            lhs = "<leader>fh",
            rhs = "<cmd>Telescope help_tags<cr>",
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
          {
            desc = "Suggest spellings",
            lhs = "<leader>fs",
            rhs = "<cmd>Telescope spell_suggest<cr>",
          },
        },
      },
    }
  end,

  base46 = "telescope",
}
