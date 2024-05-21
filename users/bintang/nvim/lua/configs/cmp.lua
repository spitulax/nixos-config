local cmp = require("cmp")
local base = require("nvchad.configs.cmp")

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
    mapping = {
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
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),

      -- Disabled
      ["<CR>"] = vim.NIL,
      ["<C-Space>"] = vim.NIL,
      ["<C-e>"] = vim.NIL,
      ["<C-d>"] = vim.NIL,
      ["<C-f>"] = vim.NIL,
    },

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
  local cmdline_mapping = {
    ["<CR>"] = { c = false },
    ["<C-n>"] = { c = false },
    ["<C-p>"] = { c = false },
    ["<M-n>"] = {
      c = cmp.mapping.select_next_item(),
    },
    ["<M-p>"] = {
      c = cmp.mapping.select_prev_item(),
    },
    ["<C-l>"] = {
      c = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
    },
  }

  -- Search (forward)
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
    sources = {
      { name = 'buffer' },
    },
  })

  -- Command mode
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
    sources = {
      { name = "path" },
      { name = "cmdline" },
    },
  })
end

return {
  config = function()
    config_cmp()
    config_cmdline()
  end,
}
