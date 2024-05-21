local M = {}

M = {
  ---@param plugin PluginName
  load_on_git = function(plugin)
    vim.api.nvim_create_autocmd({ "BufRead" }, {
      callback = function()
        vim.fn.jobstart({"git", "-C", vim.uv.cwd(), "rev-parse"}, {
          on_exit = function(_, return_code)
            if return_code == 0 then
              vim.schedule(function()
                require("lazy").load { plugins = { plugin } }
              end)
            end
          end
        })
      end,
    })
  end,

  ---@param prompt string
  ---@param completion string
  ---@param callback function
  prompt_callback = function(prompt, completion, callback)
    vim.ui.input({prompt = prompt .. ": ", completion = completion}, function(input)
      if input and string.gsub(input, " ", "") ~= "" then callback(input) end
    end)
  end,
}

return M
