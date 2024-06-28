local utils = require("utils")

---@type PluginConfig
return {
  opts = {
    plugins = {
      marks = false,
    },
    window = {
      padding = { 0, 0, 0, 0 },
    },
    layout = {
      height = { min = 4, max = 12 },
    },
  },

  mappings = {
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
  },
}
