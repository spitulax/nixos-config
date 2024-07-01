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

---@param tbls MappingTable[]
M.apply_mappings = function(tbls)
  local mappings = {}
  for _, v in ipairs(tbls) do
    mappings = vim.tbl_deep_extend("error", mappings, v)
  end

  for section_name, section in pairs(mappings) do
    for mode, maps in pairs(section) do
      assert(vim.isarray(maps), "Mode mapping is not an array at section " .. section_name)
      for _, map in ipairs(maps) do
        if mode == "a" then
          mode = { "n", "v", "x" }
        end
        map.desc = section_name .. " " .. map.desc
        M.mymap(mode, map)
      end
    end
  end
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
  vim.opt.shiftwidth = n
  vim.opt.tabstop = n
  vim.opt.softtabstop = n
end

return M
