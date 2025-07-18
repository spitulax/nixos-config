local utils = require("utils")

---@return LazyPluginSpec[]
local specs = require("extra_plugins")

for k, v in pairs(utils.plugin_configs()) do
  if v.disable then
    goto continue
  end

  local plug_opts = {}
  if vim.is_callable(v.opts) then
    plug_opts = v.opts()
  else
    plug_opts = nil
  end

  ---@type LazyPluginSpec
  local spec = {}
  assert(v.spec ~= nil, k .. ": Incomplete config")
  assert(
    v.spec.opts == nil or v.spec.config,
    k .. ": Do not specify `opts` or `config` in `PluginConfig.spec`"
  )
  spec = vim.tbl_extend("force", v.spec, {
    config = v.config or true,
    opts = function(_, _)
      return plug_opts
    end,
  })

  ---@type LazyPluginSpec
  local override = {}
  if k == "plugins.nvimtree" then
    override.opts = function(_, _)
      return vim.tbl_deep_extend("keep", plug_opts, require("nvchad.configs.nvimtree"))
    end
  elseif k == "plugins.gitsigns" then
    override.opts = function()
      return vim.tbl_deep_extend("keep", plug_opts, require("nvchad.configs.gitsigns"))
    end
  elseif k == "plugins.lspconfig" then
    override.config = function(this, opts)
      require("nvchad.configs.lspconfig").defaults()
      v.config(this, opts)
    end
  end
  spec = vim.tbl_extend("force", spec, override)

  table.insert(specs, spec)

  ::continue::
end

return specs
