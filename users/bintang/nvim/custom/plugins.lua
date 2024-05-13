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
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },

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
    dependencies = { "luarocks.nvim" },
    -- build = ":Neorg sync-parsers", -- neorg provides it's own build script
    cmd = "Neorg",
    opts = function()
      return require("custom.configs.neorg").opts
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      return vim.tbl_deep_extend("force", require("plugins.configs.treesitter"),
        require("custom.configs.treesitter").opts)
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
      return vim.tbl_deep_extend("force", require("plugins.configs.nvimtree"),
        require("custom.configs.nvimtree").opts)
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    init = function()
      load_on_git("gitsigns.nvim")
      load_mappings("gitsigns", { silent = true })
    end,
    opts = function()
      return vim.tbl_deep_extend("force", require("plugins.configs.others").gitsigns,
        require("custom.configs.gitsigns").opts)
    end,
  },

  {
    "williamboman/mason.nvim",
    enabled = false,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      local lspconfig = require("lspconfig")
      local on_attach = require("plugins.configs.lspconfig").on_attach
      local capabilities = require("plugins.configs.lspconfig").capabilities
      require("custom.configs.lspconfig").setup(lspconfig, on_attach, capabilities)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
    },
    config = function(_, _)
      require("custom.configs.cmp").setup()
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
          return require("custom.configs.neoclip").opts
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
      return vim.tbl_deep_extend("force", require("plugins.configs.telescope"),
        require("custom.configs.telescope").opts)
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
      require('mini.surround').setup({
        mappings = {
          add = 'Sa',
          delete = 'Sd',
          find = 'Sf',
          find_left = 'SF',
          highlight = 'Sh',
          replace = 'Sr',
          update_n_lines = 'Sn',
        },
      })
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function()
      return vim.tbl_deep_extend("force", require("plugins.configs.others").blankline,
        require("custom.configs.blankline").opts)
    end
  },

  {
    "folke/which-key.nvim",
    opts = function()
      return require("custom.configs.which-key").opts
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
      return require("custom.configs.neogit").opts
    end,
    cmd = "Neogit",
  },

  {
    'stevearc/dressing.nvim',
    event = { "BufEnter" },
    opts = function()
      return require("custom.configs.dressing").opts
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
      return require("custom.configs.live-command").opts
    end,
    config = function(_, opts)
---@diagnostic disable-next-line: different-requires
      require("live-command").setup(opts) -- lazy.nvim default config function didn't work
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
      return require("custom.configs.git_conflict").opts
    end,
  },

  {
    "smoka7/hop.nvim",
    version = "*",
    init = function()
      dofile(vim.g.base46_cache .. "hop")
      lazy_load("hop.nvim")
      load_mappings("hop", { silent = true })
    end,
    opts = function()
      return require("custom.configs.hop").opts
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
      return require("custom.configs.spectre").opts
    end,
  },

  {
    "folke/todo-comments.nvim",
    init = function()
      lazy_load("todo-comments.nvim")
      load_mappings("todo")
    end,
    config = true,
  },

  {
    "christoomey/vim-tmux-navigator",
    init = function()
      load_mappings("vim_tmux")
    end,
    lazy = false,
  },

  {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = function()
      return require("custom.configs.conform").opts
    end,
  },
}

return M
