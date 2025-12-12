local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

autocmd("VimEnter", {
  callback = function()
    require("base46").load_all_highlights()
  end,
})

-- Execute autocmd event 'User FilePost' when entering UI and editing "real" file.
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("UserFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds(
        "User",
        { pattern = "FilePost", modeline = false }
      )
      vim.api.nvim_del_augroup_by_name("UserFilePost")

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

usercmd("Indent", function(arg)
  local n = tonumber(arg.args)
  if n ~= nil then
    require("utils").indent(n)
  else
    vim.api.nvim_echo(
      { { "`" .. arg.args .. "` is not a valid number" } },
      true,
      { err = true }
    )
  end
end, { desc = "Set default indentation for the current buffer", nargs = 1 })

vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "php",
  },
})
