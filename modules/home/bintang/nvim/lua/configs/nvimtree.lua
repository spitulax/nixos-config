return {
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
          }
        },
      },
    }
  end,
}
