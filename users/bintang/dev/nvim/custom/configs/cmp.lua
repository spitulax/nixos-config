local cmp = require("cmp")

local opts = vim.tbl_deep_extend("force", require("plugins.configs.cmp"), {
  preselect = cmp.PreselectMode.None,
  completion = {
    keyword_length = 2,
  },
  view = {
    docs = {
      auto_open = false,
    },
  },
  mapping = {
    ["<M-x>"] = cmp.mapping.close(),
    ["<C-Space>"] = function()
      if cmp.visible() then cmp.close()
      else cmp.complete() end
    end,
    ["<M-z>"] = cmp.mapping.abort(),
    ["<M-d>"] = function()
      if cmp.visible_docs() then cmp.close_docs()
      else cmp.open_docs() end
    end,
    ["<Tab>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),

    -- disabled
    ["<CR>"] = vim.NIL,
    ["<C-e>"] = vim.NIL,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
    { name = "nvim_lua" },
  },
})

cmp.setup(opts)

local cmdline_mapping = {
  ["<C-n>"] = {
    c = false,
  },
  ["<C-p>"] = {
    c = false,
  },
  ["<C-l>"] = {
    c = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
}

cmp.setup.cmdline('/', {
 mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})
