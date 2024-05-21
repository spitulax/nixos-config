local utils = require("utils")

return {
  "nvim-lua/popup.nvim",

  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },

  {
    "nvim-neorg/neorg",
    ft = "norg",
    dependencies = { "luarocks.nvim" },
    -- build = ":Neorg sync-parsers", -- neorg provides it's own build script
    cmd = "Neorg",
    opts = require("configs.neorg").opts,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require("configs.treesitter").opts,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = utils.override("nvchad.configs.nvimtree", require("configs.nvimtree").opts()),
  },

  {
    "lewis6991/gitsigns.nvim",
    -- init = function()
    --   utils.load_on_git("gitsigns.nvim")
    -- end,
    opts = utils.override("nvchad.configs.gitsigns", require("configs.gitsigns").opts()),
  },

  {
    "williamboman/mason.nvim",
    enabled = false,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig").config()
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
    },
    config = require("configs.cmp").config,
  },

  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "AckslD/nvim-neoclip.lua",
        opts = require("configs.neoclip").opts,
      },
    },
  },

  {
    'echasnovski/mini.nvim',
    version = false,
    lazy = false,
    config = require("configs.mini").config,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = require("configs.blankline").opts,
  },

  {
    "folke/which-key.nvim",
    opts = require("configs.whichkey").opts,
  },

  {
    'sindrets/diffview.nvim',
    config = true,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },

  {
    "NeogitOrg/neogit",
    opts = require("configs.neogit").opts,
    cmd = "Neogit",
  },

  {
    'stevearc/dressing.nvim',
    event = "BufEnter",
    opts = require("configs.dressing").opts,
  },

  {
    "ziontee113/icon-picker.nvim",
    event = "User FilePost",
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end
  },

  {
    "smjonas/live-command.nvim",
    event = "User FilePost",
    opts = require("configs.live-command").opts,
    config = function(_, opts)
      ---@diagnostic disable-next-line: different-requires
      require("live-command").setup(opts) -- lazy.nvim default config function didn't work
    end,
  },

  {
    'akinsho/git-conflict.nvim',
    init = function()
      utils.load_on_git("git-conflict.nvim")
    end,
    opts = {
      default_mappings = false,
    },
  },

  {
    "smoka7/hop.nvim",
    event = "User FilePost",
    opts = {
      multi_windows = true,
    },
    config = true,
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    config = true,
  },

  {
    "nvim-pack/nvim-spectre",
    event = "User FilePost",
    opts = {
      is_insert_mode = true,
    },
  },

  {
    "folke/todo-comments.nvim",
    event = "User FilePost",
    config = true,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = require("configs.conform").opts,
  },
}
