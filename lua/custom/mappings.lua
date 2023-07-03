local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle breakpoint"
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets')
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar"
    },
    ["<F5>"] = {
      "<cmd> DapContinue <CR>",
      "Start debugging or continue if already in debugging"
    },
    ["<leader><F5>"] = {
      "<cmd> DapTerminate <CR>",
      "Stop Debugging",
    },
    ["<F8>"] = {
      "<cmd> DapStepOver <CR>",
      "Step Over",
    },
    ["<F7>"] = {
      "<cmd> DapStepInto <CR>",
      "Step Into",
    },
    ["<leader><F7>"] = {
      "<cmd> DapStepOut <CR>",
      "Step Out",
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

return M
