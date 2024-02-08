local opts = {
  mappings = {
    n = { ["<C-c>"] = require("telescope.actions").close },
  },

  extensions_list = { "media_files", "neoclip", "projects" },
  extensions = {
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
      find_cmd = "rg"
    },
  },
}

return opts
