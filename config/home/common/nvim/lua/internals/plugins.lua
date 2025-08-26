local utils = require("utils")

---@return LazyPluginSpec[]
local specs = require("extra_plugins")

for k, v in pairs(utils.plugin_configs()) do
  if v.disable then
    goto continue
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
      ---@diagnostic disable-next-line
      if vim.islist(v.base46) then
        for _, x in ipairs(v.base46) do
          dofile(vim.g.base46_cache .. x)
        end
      elseif v.base46 ~= nil then
        dofile(vim.g.base46_cache .. v.base46)
      end

      if vim.is_callable(v.opts) then
        return v.opts()
      else
        return nil
      end
    end,
  })

  table.insert(specs, spec)

  ::continue::
end

return specs
