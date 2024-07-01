--- Completion engine.

local base = require("nvchad.configs.cmp")
local cmp = require("cmp")

local mappings = {
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

local cmdline_mappings = (function()
  local result = {}
  for k, v in pairs(mappings) do
    result[k] = { c = v }
  end
  return cmp.mapping.preset.cmdline(result)
end)()

local function config_cmp()
  local opts = {
    preselect = cmp.PreselectMode.None,
    completion = {
      keyword_length = 2,
    },
    view = {
      docs = {
        auto_open = false,
      },
    },
    mapping = mappings,

    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
      { name = "buffer" },
      { name = "nvim_lua" },
    },
  }

  cmp.setup(vim.tbl_deep_extend("force", base, opts))
end

local function config_cmdline()
  -- Search (forward)
  cmp.setup.cmdline("/", {
    mapping = cmdline_mappings,
    sources = {
      { name = "buffer" },
    },
  })

  -- Command mode
  cmp.setup.cmdline(":", {
    mapping = cmdline_mappings,
    sources = {
      { name = "path" },
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
    },
  },

  config = function(_, _)
    config_cmp()
    config_cmdline()
  end,
}
