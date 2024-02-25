local M = {}

M.mappings = {
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

return M
