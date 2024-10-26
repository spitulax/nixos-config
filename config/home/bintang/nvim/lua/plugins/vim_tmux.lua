--- Navigate back and forth from neovim inside tmux to another tmux panel.

---@type PluginConfig
return {
  spec = {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
  },

  mappings = function()
    return {
      TmuxNavigation = {
        n = {
          {
            desc = "Window left",
            lhs = "<C-h>",
            rhs = "<cmd>TmuxNavigateLeft<cr>",
          },
          {
            desc = "Window down",
            lhs = "<C-j>",
            rhs = "<cmd>TmuxNavigateDown<cr>",
          },
          {
            desc = "Window up",
            lhs = "<C-k>",
            rhs = "<cmd>TmuxNavigateUp<cr>",
          },
          {
            desc = "Window right",
            lhs = "<C-l>",
            rhs = "<cmd>TmuxNavigateRight<cr>",
          },
          {
            desc = "Window previous",
            lhs = "<C-\\>",
            rhs = "<cmd>TmuxNavigatePrevious<cr>",
          },
        },
      },
    }
  end,

  config = function(_, _) end,
}
