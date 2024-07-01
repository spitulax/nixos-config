local M = {}

local utils = require("utils")

---@type string[]
local modules = {}
for name, _ in vim.fs.dir(utils.plugin_config_path) do
  table.insert(modules, "plugins." .. name:gsub(".lua", "", 1))
end

--- `opts` and `mappings` are only able to be evaluated after loading the plugins
---@type table<string, PluginConfig>
M.configs = (function()
  local configs = {}
  for _, module in ipairs(modules) do
    ---@type PluginConfig
    local config = require(module)
    configs[module] = config
  end
  return configs
end)()

---@type LazyPluginSpec[]
local extra_config = {
  { "nvim-lua/popup.nvim" },

  {
    "williamboman/mason.nvim",
    enabled = false,
  },
}

---@return LazyPluginSpec[]
M.specs = function()
  local specs = extra_config
  for k, v in pairs(M.configs) do
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
        if vim.is_callable(v.opts) then
          return v.opts()
        else
          return nil
        end
      end,
    })

    if k == "plugins.nvimtree" then
      spec.opts = function()
        return vim.tbl_deep_extend("keep", v.opts(), require("nvchad.configs.nvimtree"))
      end
    elseif k == "plugins.gitsigns" then
      spec.opts = function()
        return vim.tbl_deep_extend("keep", v.opts(), require("nvchad.configs.gitsigns"))
      end
    elseif k == "plugins.lspconfig" then
      spec.config = function(self, opts)
        require("nvchad.configs.lspconfig").defaults()
        v.config(self, opts)
      end
    end

    table.insert(specs, spec)
  end
  return specs
end

return M
