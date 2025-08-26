--- Highlights special comments, e.g. `TODO`, `FIXME`, `FAILED`, etc.

---@type PluginConfig
return {
  spec = {
    "folke/todo-comments.nvim",
    event = "User FilePost",
    cmd = "TodoTelescope",
  },

  opts = function()
    return {
      keywords = {
        MAYBEFIXED = { icon = "", color = "hint", alt = { "OLDBUG", "OLDISSUE" } },
        MAYBE = {
          icon = "✓",
          color = "info",
        },
        TEMP = { icon = "󰅐", color = "error" },
        REFACTOR = { icon = "󰹈", color = "error" },
        DOCS = { icon = "󰧮", color = "info", alt = { "DOC" } },
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
            rhs = function()
              require("todo-comments").jump_prev()
            end,
          },
          {
            desc = "Todo Jump to next todo comment",
            lhs = "]t",
            rhs = function()
              require("todo-comments").jump_next()
            end,
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

  base46 = "todo",
}
