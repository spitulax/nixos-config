local M = {}

M.mappings = {
  n = {
    ["[t"] = {
      function()
        require("todo-comments").jump_prev()
      end,
      "Jump to previous todo comment"
    },
    ["]t"] = {
      function()
        require("todo-comments").jump_next()
      end,
      "Jump to next todo comment"
    },
    ["fq"] = { "<cmd>TodoTelescope<CR>", "Search all todo comments" },
  },
}

return M
