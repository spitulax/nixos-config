local M = {}

---@param plugin PluginName
M.load_on_git = function(plugin)
  vim.api.nvim_create_autocmd({ "BufRead" }, {
    callback = function()
      ---@diagnostic disable-next-line: undefined-field
      vim.fn.jobstart({ "git", "-C", vim.uv.cwd(), "rev-parse" }, {
        on_exit = function(_, return_code)
          if return_code == 0 then
            vim.schedule(function()
              require("lazy").load({ plugins = { plugin } })
            end)
          end
        end,
      })
    end,
  })
end

---@param prompt string
---@param completion string
---@param callback function
M.prompt_callback = function(prompt, completion, callback)
  local opts = {}
  opts.prompt = prompt .. ": "
  if completion:len() > 0 then
    opts.completion = completion
  end
  vim.ui.input(opts, function(input)
    if input and string.gsub(input, " ", "") ~= "" then
      callback(input)
    end
  end)
end

---@param mode string|string[]
---@param m Mappings
M.mymap = function(mode, m)
  local opts = m.opts or {}
  if m.desc then
    opts = vim.tbl_extend("error", opts, { desc = m.desc })
  end
  vim.keymap.set(mode, m.lhs, m.rhs, opts)
end

-- HACK:
---@type string
---@diagnostic disable-next-line: assign-type-mismatch
M.config_path = vim.fn.stdpath("config")
assert(type(M.config_path) == "string")

---@type string
M.plugin_config_path = vim.fs.joinpath(M.config_path, "lua/plugins")

---@type string
M.language_config_path = vim.fs.joinpath(M.config_path, "lua/languages")

---@param name string
---@param opts table
M.setup = function(name, opts)
  require(name).setup(opts)
end

---@param n number
M.indent = function(n)
  vim.bo.shiftwidth = n
  vim.bo.tabstop = n
  vim.bo.softtabstop = n
end

---@return table<string, PluginConfig>
M.plugin_configs = function()
  local configs = {}
  for name, _ in vim.fs.dir(M.plugin_config_path) do
    local module_name = "plugins." .. name:gsub(".lua", "", 1)
    configs[module_name] = require(module_name)
  end
  return configs
end

---@param factor? number
---@return string
M.global_multiplier = function(factor)
  if factor == nil then
    factor = 1
  end
  return tostring(vim.g.global_multiplier * factor)
end

return M
