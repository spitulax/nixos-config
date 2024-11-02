local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

autocmd("VimEnter", {
  callback = function()
    require("base46").load_all_highlights()
  end,
})

autocmd({ "BufNewFile", "BufReadPost" }, {
  callback = function()
    vim.cmd("TSEnable highlight")
    vim.cmd("TSEnable indent")
  end,
})

-- Most of the time I want to commit using Neogit the COMMIT_EDITMSG buffer is unmodifiable
-- and I don't know why that happens but this fixes it
autocmd("FileType", {
  callback = function(arg)
    if vim.bo[arg.buf].filetype == "NeogitCommitMessage" then
      vim.bo[arg.buf].modifiable = true
    end
  end,
})

usercmd("Indent", function(arg)
  local n = tonumber(arg.args)
  if n ~= nil then
    require("utils").indent(n)
  else
    vim.api.nvim_err_writeln("`" .. arg.args .. "` is not a valid number")
  end
end, { desc = "Set default indentation for the current buffer", nargs = 1 })
