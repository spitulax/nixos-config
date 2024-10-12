local autocmd = vim.api.nvim_create_autocmd

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
