--- Completion engine.

local mappings = function(cmp)
  return {
    -- Close
    ["<M-x>"] = cmp.mapping.close(),

    -- Toggle
    ["<M-s>"] = cmp.mapping(function(_)
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete()
      end
    end),

    -- Abort
    ["<M-z>"] = cmp.mapping.abort(),

    -- Docs
    ["<M-h>"] = cmp.mapping(function(_)
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.open_docs()
      end
    end),

    -- Scroll docs
    ["<M-[>"] = cmp.mapping.scroll_docs(-4),
    ["<M-]>"] = cmp.mapping.scroll_docs(4),

    -- Confirm
    ["<Tab>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<M-l>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),

    -- Selection
    ["<M-n>"] = cmp.mapping.select_next_item(),
    ["<M-p>"] = cmp.mapping.select_prev_item(),

    -- Disabled
    ["<CR>"] = vim.NIL,
    ["<C-n>"] = vim.NIL,
    ["<C-p>"] = vim.NIL,
    ["<C-Space>"] = vim.NIL,
    ["<C-e>"] = vim.NIL,
    ["<C-d>"] = vim.NIL,
    ["<C-f>"] = vim.NIL,
  }
end

local cmdline_mappings = function(cmp, mapping)
  local result = {}
  for k, v in pairs(mapping) do
    result[k] = { c = v }
  end
  return cmp.mapping.preset.cmdline(result)
end

local function config_cmp(cmp, mapping)
  local opts = {
    preselect = cmp.PreselectMode.None,
    completion = {
      keyword_length = 2,
      completeopt = "menu,menuone",
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    view = {
      docs = {
        auto_open = false,
      },
    },
    mapping = mapping,

    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "async_path" },
      { name = "buffer" },
      { name = "nvim_lua" },
    },
  }

  cmp.setup(vim.tbl_deep_extend("force", opts, require("nvchad.cmp")))
end

local function config_cmdline(cmp, cmdline_mapping)
  -- Search (forward)
  cmp.setup.cmdline("/", {
    mapping = cmdline_mapping,
    sources = {
      { name = "buffer" },
    },
  })

  -- Command mode
  cmp.setup.cmdline(":", {
    mapping = cmdline_mapping,
    sources = {
      { name = "async_path" },
      { name = "cmdline" },
    },
  })
end

---@type PluginConfig
return {
  spec = {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "windwp/nvim-autopairs",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "https://codeberg.org/FelipeLema/cmp-async-path.git",
    },
  },

  config = function(_, _)
    local cmp = require("cmp")
    local mapping = mappings(cmp)
    local cmdline_mapping = cmdline_mappings(cmp, mapping)

    config_cmp(cmp, mapping)
    config_cmdline(cmp, cmdline_mapping)
  end,

  base46 = "cmp",
}
