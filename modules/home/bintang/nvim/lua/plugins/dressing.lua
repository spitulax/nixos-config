--- Replace `vim.ui.input` and `vim.ui.select` prompt with something fancy.

---@type PluginConfig
return {
  spec = {
    "stevearc/dressing.nvim",
    event = "BufEnter",
  },

  opts = function()
    return {
      input = {
        default_prompt = "Input: ",
        title_pos = "center",
        insert_only = false,
        start_in_insert = true,
        border = "rounded",
        relative = "editor",
        prefer_width = 0.8,
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<C-p>"] = "HistoryPrev",
            ["<C-n>"] = "HistoryNext",
          },
        },
      },
    }
  end,
}
