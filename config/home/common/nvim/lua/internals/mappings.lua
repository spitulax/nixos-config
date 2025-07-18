local general_mapping = require("mappings")
local utils = require("utils")

local mappings = general_mapping
for _, v in pairs(utils.plugin_configs()) do
  if v.disable then
    goto continue
  end
  if vim.is_callable(v.mappings) then
    mappings = vim.tbl_deep_extend("error", mappings, v.mappings())
  end
  ::continue::
end

for section_name, section in pairs(mappings) do
  for mode, maps in pairs(section) do
    assert(vim.isarray(maps), "Mode mapping is not an array at section " .. section_name)
    for _, map in ipairs(maps) do
      local actual_mode = { mode }
      if actual_mode[1] == "a" then
        actual_mode = { "n", "v", "x" }
      end
      map.desc = section_name .. " " .. map.desc
      utils.mymap(actual_mode, map)
    end
  end
end
