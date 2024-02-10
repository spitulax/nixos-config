local lazy_load = require("core.utils").lazy_load
local load_mappings = require("core.utils").load_mappings

local function load_on_git(plugin)
  vim.api.nvim_create_autocmd({ "BufRead" }, {
    callback = function()
      vim.fn.jobstart({"git", "-C", vim.loop.cwd(), "rev-parse"},
        {
          on_exit = function(_, return_code)
            if return_code == 0 then
              vim.schedule(function()
                require("lazy").load { plugins = { plugin } }
              end)
            end
          end
        }
      )
    end,
  })
end

local M = {
  "nvim-lua/popup.nvim",

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
      flavour = "mocha",
    },
    priority = 1000,
  },

  {
    "nvim-neorg/neorg",
    ft = "norg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return require("custom.configs.neorg")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      return vim.tbl_deep_extend("force", require("plugins.configs.treesitter"), require("custom.configs.treesitter"))
    end,
  },

  {
    "mg979/vim-visual-multi",
    branch = "master",
    enabled = false,
    init = function()
      lazy_load("vim-visual-multi")
    end,
    config = function()
      require("custom.configs.vim-visual-multi")
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      return vim.tbl_deep_extend("force", require("plugins.configs.nvimtree"), require("custom.configs.nvim-tree"))
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    init = function()
      load_on_git("gitsigns.nvim")
      load_mappings("gitsigns", { silent = true })
    end,
    opts = function()
      return vim.tbl_deep_extend("force", require("plugins.configs.others").gitsigns, require("custom.configs.others").gitsigns)
    end,
  },

  {
    "williamboman/mason.nvim",
    enabled = false,
    opts = function()
      return require("custom.configs.mason")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return vim.tbl_deep_extend("force", require("plugins.configs.cmp"), require("custom.configs.cmp"))
    end
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    init = function()
      load_mappings("harpoon")
    end,
    config = function(_, _)
      require("harpoon").setup({})
    end,
  },

  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    lazy = false,
    dependencies = {
      'nvim-telescope/telescope-media-files.nvim',
      {
        "AckslD/nvim-neoclip.lua",
        opts = function()
          return require("custom.configs.others").neoclip
        end
      },
      {
        "ahmedkhalf/project.nvim",
        config = function(_, opts)
          require("project_nvim").setup(opts)
        end,
      },
    },
    opts = function()
      return vim.tbl_deep_extend("force", require("plugins.configs.telescope"), require("custom.configs.telescope"))
    end,
  },

  {
    'echasnovski/mini.nvim', version = false,
    init = function(_)
      lazy_load("mini.nvim")
    end,
    config = function(_, _)
      require('mini.align').setup()
      require('mini.bufremove').setup()
      require('mini.surround').setup()
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function()
      return vim.tbl_deep_extend("force", require("plugins.configs.others").blankline, require("custom.configs.others").blankline)
    end
  },

  {
    "folke/which-key.nvim",
    opts = function()
      return require("custom.configs.which-key")
    end,
  },

  {
    'sindrets/diffview.nvim',
    config = true,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },

  {
    "NeogitOrg/neogit",
    init = function()
      load_mappings("neogit", { silent = true })
    end,
    opts = function()
      return require("custom.configs.neogit")
    end,
    cmd = "Neogit",
  },

  {
    'stevearc/dressing.nvim',
    event = { "BufEnter" },
    opts = function()
      return require("custom.configs.dressing")
    end,
  },

  {
    "ziontee113/icon-picker.nvim",
    init = function()
      lazy_load("icon-picker.nvim")
      load_mappings("icon_picker", { silent = true })
    end,
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end
  },

  {
    "smjonas/live-command.nvim",
    init = function()
      lazy_load("live-command.nvim")
    end,
    opts = function()
      return require("custom.configs.live-command")
    end,
    config = function(_, opts)
---@diagnostic disable-next-line: different-requires
      require("live-command").setup(opts)
    end,
  },

  {
    'akinsho/git-conflict.nvim',
    version = "*",
    init = function()
      load_on_git("git-conflict.nvim")
      load_mappings("git_conflict", { silent = true })
    end,
    opts = function()
      return require("custom.configs.others").git_conflict
    end,
  },

  {
    "smoka7/hop.nvim",
    version = "*",
    init = function()
      lazy_load("hop.nvim")
      load_mappings("hop", { silent = true })
    end,
    opts = function()
      return require("custom.configs.others").hop
    end,
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    config = true,
  },

  {
    "nvim-pack/nvim-spectre",
    init = function()
      lazy_load("nvim-spectre")
      load_mappings("spectre")
    end,
    opts = function()
      return require("custom.configs.others").spectre
    end,
  },
}

return M
