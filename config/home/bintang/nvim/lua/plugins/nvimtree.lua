--- Show file structure in a sidebar.

---@type PluginConfig
return {
  spec = { "nvim-tree/nvim-tree.lua" },

  opts = function()
    return {
      modified = {
        enable = true,
        show_on_dirs = false,
      },
      view = {
        signcolumn = "auto",
      },
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        highlight_modified = "name",
        root_folder_label = ":~:s?$?/..?",
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            git = true,
          },
          git_placement = "signcolumn",
          glyphs = {
            bookmark = "",
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "",
              untracked = "",
              deleted = "",
              ignored = "",
            },
          },
        },
      },
    }
  end,

  mappings = function()
    return {
      NvimTree = {
        n = {
          {
            desc = "Toggle nvim-tree",
            lhs = "<leader>e",
            rhs = "<cmd>NvimTreeToggle<CR>",
            opts = { nowait = true },
          },
          {
            desc = "Focus nvim-tree",
            lhs = "<leader>E",
            rhs = "<cmd>NvimTreeFocus<CR>",
            opts = { nowait = true },
          },
        },
      },
    }
  end,
}
