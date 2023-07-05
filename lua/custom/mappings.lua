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

M.dapui = {
  plugin = true,
  n = {
    ["<leader>duo"] = {
      function()
        require('dapui').open()
      end
    },
    ["<leader>duc"] = {
      function()
        require("dapui").close()
      end
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

M.rust = {
  plugin = true,
  n = {
    ["<leader>rd"] = {
      "<cmd> RustDebuggables <CR>",
      "Rust Debuggables",
    },
    ["<leader>rha"] = {
      "<cmd> RustHoverActions <CR> <cmd> RustHoverActions <CR>",
      "Rust Hover Actions",
    }
  }
}

M.lspconfig = {
  n = {
   ["<leader>ds"] = {
      function() 
        vim.lsp.buf.document_symbol()
      end,
      "Document Symbols"
    } 
  }
}

M.neogit = {
  plugin = true,
  n = {
    ["<leader>ng"] = {
      function()
        require('neogit').open()
      end,
      "Open Git Commit View"
    },
    ["<leader>cng"] = {
      function()
        require('neogit').close()
      end,
      "Close Git Commit View"
    }
  }
}
return M
