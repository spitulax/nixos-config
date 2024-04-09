local M = {}

M.opts = {
  extensions_list = { "neoclip" },
}

M.mappings = {
  n = {
    ["<leader>tr"] = { "<cmd> Telescope resume <CR>", "Resume Telescope" },
    -- find
    ["<leader>fe"] = {
      function()
        prompt_callback("Find files in", "file", function(input)
          vim.cmd("Telescope find_files cwd=" .. input)
        end)
      end,
      "Find files in specified directory",
    },
    ["<leader>o"]   = { "<cmd> Telescope find_files <CR>", "Find files in cwd" },
    ["<M-b>"]       = { "<cmd> Telescope buffers <CR>", "Find opened buffers" },
    ["<leader>fk"]  = { "<cmd> Telescope keymaps <CR>", "Find assigned keybindings" },
    ["<leader>ft"]  = { "<cmd> Telescope builtin <CR>", "Find Telescope builtin commands" },
    ["<leader>fc"]  = { "<cmd> Telescope highlights <CR>", "List highlight groups" },
    ["<leader>fM"]  = { "<cmd> Telescope man_pages sections={'ALL'}<CR>", "Find man pages" },
    ["<leader>fH"]  = { "<cmd> Telescope man_pages sections={'3'}<CR>", "Find man pages in section 3" },
    -- git
    ["<leader>gc"]  = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gb"]  = { "<cmd> Telescope git_branches <CR>", "Git branches" },
    ["<leader>gs"]  = { "<cmd> Telescope git_stash <CR>", "Git stash" },
    -- extensions
    ["<leader>v"]  = { "<cmd> Telescope neoclip <CR>", "Preview clipboard" },
    ["<leader>p"] = { "<cmd> Telescope projects <CR>", "Project list" },
  },
}

return M
