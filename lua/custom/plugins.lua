local plugins = {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "pyright",
        "mypy",
        "ruff",
        "black",
        "debugpy",
        "typescript-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust", 
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "neovim/nvim-lspconfig",
    },
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require('rust-tools').setup(opts)
      require('core.utils').load_mappings("rust")
      require("dap").configurations["rust"] = {
          {
            type = "rt_lldb",
            request = "attach",
            name = "Attach Rust",
            pid = require'dap.utils'.pick_process,
         }
        }

    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "saecki/crates.nvim",
    ft = {"rust", "toml"},
    config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {name = "crates"})
      return M
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python", "typescript", "javascript"},
    opts = function ()
      return require "custom.configs.null-ls"
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function (_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,

  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      require("core.utils").load_mappings("dapui")
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        "rust",
        "python",
        "typescript",
        "javascript",
        "toml",
        "c",
        "cpp",
        "cuda",
      }
    }
  },
  {
    "codota/tabnine-nvim",
    build = "./dl_binaries.sh",
    lazy = false,
    config = function ()
      require('tabnine').setup({})
    end
  },
  {
    "sindrets/diffview.nvim",
    lazy = false
  },
  {
    'NeogitOrg/neogit', 
    lazy = false,
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup({
        disable_commit_confiramtion = true,
        integrations = {
          diffview = true
        }
      })
      require('core.utils').load_mappings('neogit')
    end
  },
  {
     "microsoft/vscode-js-debug",
     build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = {"javascript", "typescript"},
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("dap-vscode-js").setup({
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        debugger_path = vim.env.HOME .. "/.local/share/nvim/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
        -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
        -- log_file_path = "~/logs/ts-debug.log", -- Path for file logging
        -- log_file_level = vim.log.levels.DEBUG, -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.DEBUG -- Logging level for output to console. Set to false to disable console output.
      })

      for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
         }
        }
      end
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      renderer = {
        root_folder_label = true,
      }
    }
  }
}

return plugins
