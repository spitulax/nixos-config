--- Highlights special comments, e.g. `TODO`, `FIXME`, `FAILED`, etc.

---@type PluginConfig
return {
  spec = {
    "folke/todo-comments.nvim",
    event = "User FilePost",
  },

  opts = function()
    return {
      keywords = {
        MAYBEFIXED = { icon = "", color = "hint", alt = { "OLDBUG", "OLDISSUE" } },
        MAYBE = {
          icon = "✓",
          color = "info",
          alt = { "LOWTODO", "NOTREALLYIMPORTANT", "NOTIMPORTANT" },
        },
        TEMP = { icon = "󰅐", color = "error" },
      },
    }
  end,

  mappings = function()
    return {
      Todo = {
        n = {
          {
            desc = "Todo Jump to previous todo comment",
            lhs = "[t",
            rhs = require("todo-comments").jump_prev,
          },
          {
            desc = "Todo Jump to next todo comment",
            lhs = "]t",
            rhs = require("todo-comments").jump_next,
          },
          {
            desc = "Search all todo comments",
            lhs = "fq",
            rhs = "<cmd>TodoTelescope<cr>",
          },
        },
      },
    }
  end,
}
