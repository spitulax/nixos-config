--- Tells what actions are available for keybinds.

local utils = require("utils")

---@type PluginConfig
return {
  spec = {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
  },

  opts = function()
    return {
      plugins = {
        marks = false,
      },
      win = {
        padding = { 0, 0, 0, 0 },
      },
      layout = {
        height = { min = 4, max = 12 },
      },
    }
  end,

  mappings = function()
    return {
      WhichKey = {
        n = {
          {
            desc = "All keymaps",
            lhs = "<leader>wK",
            rhs = "<cmd>WhichKey<cr>",
          },
          {
            desc = "Query lookup",
            lhs = "<leader>wk",
            rhs = function()
              utils.prompt_callback("WhichKey", "", function(input)
                vim.cmd("WhichKey " .. input)
              end)
            end,
          },
        },
      },
    }
  end,

  base46 = "whichkey",
}
