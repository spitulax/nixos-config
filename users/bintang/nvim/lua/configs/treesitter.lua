return {
  opts = function()
    return {
      ensure_installed = {
        "lua",
        "norg",
        "c",
        "cpp",
        "make",
        "cmake",
        "rust",
        "markdown",
        "kotlin",
        "java",
        "bash",
        "fish",
        "vimdoc",
        "make",
        "nix",
        "go",
        "meson",
      },

      highlight = {
        enable = true,
        use_languagetree = true,
      },

      indent = {
        enable = true,
      },
    }
  end,
}
