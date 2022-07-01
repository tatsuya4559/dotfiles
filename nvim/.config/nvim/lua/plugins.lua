return require("packer").startup(function()
  -- packer itself -----------------------------------------
  use "wbthomason/packer.nvim"

  -- lsp ---------------------------------------------------
  use {
    { "williamboman/nvim-lsp-installer" },
    {
      "neovim/nvim-lspconfig",
      requires = "folke/lua-dev.nvim",
      after = "nvim-lsp-installer",
      config = function()
        require("nvim-lsp-installer").setup {}
        local lspconfig = require("lspconfig")
        local luadev = require("lua-dev").setup {}
        luadev.settings.Lua.diagnostics = {
          globals = { "use" }
        }
        lspconfig.sumneko_lua.setup(luadev)
        lspconfig.pyright.setup {}
        lspconfig.gopls.setup {}
        lspconfig.tsserver.setup {}
        lspconfig.ocamllsp.setup {}
        lspconfig.bashls.setup {}
        lspconfig.terraformls.setup {}
      end
    }
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup {
        -- see https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        sources = {
          -- for sh
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.shfmt,
        },
      }
    end
  }

  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        icons = false,
        fold_open = "v",
        fold_closed = ">",
        signs = {
          error = "E",
          warning = "W",
          hint = "H",
          information = "I",
          other = "?",
        }
      }
    end
  }

  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup {}
    end
  }

  -- editing -----------------------------------------------
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup {
        mapping = cmp.mapping.preset.insert({
          ["<c-b>"] = cmp.mapping.scroll_docs(-4),
          ["<c-f>"] = cmp.mapping.scroll_docs(4),
          ["<c-x><c-o>"] = cmp.mapping.complete({}),
          ["<c-e>"] = cmp.mapping.abort(),
          ["<cr>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "vsnip" },
          { name = "buffer" },
        },
      }
      -- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    end
  }

  use "machakann/vim-sandwich"

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {}
    end
  }

  use "hrsh7th/vim-vsnip"

  use "mattn/emmet-vim"

  -- use {
  --   "zbirenbaum/copilot.lua",
  --   requires = "github/copilot.vim",
  --   event = { "VimEnter" },
  --   config = function()
  --     vim.defer_fn(function()
  --       require("copilot").setup {}
  --     end, 100)
  --   end
  -- }

  -- movement ----------------------------------------------
  use "haya14busa/vim-asterisk"

  -- terminal ----------------------------------------------
  use {
    "akinsho/toggleterm.nvim",
    tag = "v1.*",
    config = function()
      require("toggleterm").setup {}
    end
  }

  use "thinca/vim-quickrun"

  -- fuzzy finder ------------------------------------------
  use {
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("telescope").setup {
        defaults = {
          layout_strategy = "vertical"
        }
      }
    end
  }

  -- file explorer -----------------------------------------
  use "tatsuya4559/filer.vim"

  -- git ---------------------------------------------------
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {}
    end
  }
  use {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 0
    end
  }
  use "lambdalisue/gina.vim"

  -- test --------------------------------------------------
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require("neotest-python") {
            dap = { justMyCode = false },
            runner = "pytest" -- can be a function to return dynamic value
          },
          require("neotest-go")
        }
      }
    end
  }

  -- debug -------------------------------------------------
  use {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local venv_python_path = string.format("%s/bin/python", os.getenv("VIRTUAL_ENV"))
      dap.adapters.python = {
        type = "executable",
        command = venv_python_path,
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            if vim.fn.executable(venv_python_path) then
              return venv_python_path
            else
              return "/usr/bin/python"
            end
          end
        }
      }
    end
  }

  use {
    "rcarriga/nvim-dap-ui",
    requires = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup {}
      dap.listeners.before.event_initialized.custom = function(session, body)
        dapui.open()
      end
      dap.listeners.before.event_terminated.custom = function(session, body)
        dapui.close()
      end
    end
  }

  use {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup {}
    end
  }

  -- colorscheme -------------------------------------------
  use {
    -- Please consider the experience with this plug-in as experimental until Tree-Sitter support in Neovim is stable!
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        --indent = { enable = true },
        ensure_installed = "all"
      }
    end
  }
  use "folke/tokyonight.nvim"
  use "projekt0n/github-nvim-theme"

  -- misc --------------------------------------------------

end)
