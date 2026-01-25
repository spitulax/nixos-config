--- Debugger adapter.

local adapters = {
  gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
  },
  ["rust-gdb"] = {
    type = "executable",
    command = "rust-gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
  },
}

local configs = {
  c = {
    {
      name = "Launch",
      type = "gdb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", "", "file")
      end,
      args = {},
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
    },
  },

  rust = {
    {
      name = "Launch",
      type = "rust-gdb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", "", "file")
      end,
      args = {},
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
    },
  },
}
configs.cpp = configs.c

---@type PluginConfig
return {
  spec = {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },

  config = function(_, opts)
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    dap.adapters = adapters
    dap.configurations = configs

    require("utils").setup("dapui", opts)
  end,

  mappings = function()
    return {
      Dap = {
        n = {
          {
            desc = "Toggle nvim-dap-ui",
            lhs = "<leader>D",
            rhs = require("dapui").toggle,
          },
          {
            desc = "New session",
            lhs = "<leader>Da",
            rhs = "<cmd>DapNew<cr>",
          },
          {
            desc = "Terminate session",
            lhs = "<leader>Dq",
            rhs = "<cmd>DapTerminate<cr>",
          },
          {
            desc = "Continue session",
            lhs = "<leader>Dc",
            rhs = "<cmd>DapContinue<cr>",
          },
          {
            desc = "Disconnect session",
            lhs = "<leader>Dd",
            rhs = "<cmd>DapPause<cr>",
          },
          {
            desc = "Restart frame",
            lhs = "<leader>Dr",
            rhs = "<cmd>DapRestartFrame<cr>",
          },
          {
            desc = "Step into",
            lhs = "<leader>Dn",
            rhs = "<cmd>DapStepInto<cr>",
          },
          {
            desc = "Step out",
            lhs = "<leader>DS",
            rhs = "<cmd>DapStepOut<cr>",
          },
          {
            desc = "Step over",
            lhs = "<leader>Ds",
            rhs = "<cmd>DapStepOver<cr>",
          },
          {
            desc = "Pause",
            lhs = "<leader>Dp",
            rhs = "<cmd>DapPause<cr>",
          },
          {
            desc = "Clear breakpoints",
            lhs = "<leader>Dx",
            rhs = "<cmd>DapClearBreakpoints<cr>",
          },
          {
            desc = "Toggle breakpoint",
            lhs = "<leader>Db",
            rhs = "<cmd>DapToggleBreakpoint<cr>",
          },
        },
      },
    }
  end,
}
