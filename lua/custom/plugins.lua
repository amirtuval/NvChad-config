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
}

return plugins
