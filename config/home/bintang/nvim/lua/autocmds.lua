require("internals.languages").autocmds()

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("base46").load_all_highlights()
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("TSEnable highlight")
    vim.cmd("TSEnable indent")
  end,
})
