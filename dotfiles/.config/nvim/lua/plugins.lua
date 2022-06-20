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
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  use {
    "glepnir/lspsaga.nvim",
    config = function()
      require("lspsaga").init_lsp_saga {}
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
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
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
          { name = "luasnip" },
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

  use {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath("config") .. "/vscode" }
      }
    end
  }

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
      local python_path = string.format("%s/bin/python", os.getenv("VIRTUAL_ENV"))
      dap.adapters.python = {
        type = "executable",
        command = python_path,
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            if vim.fn.executable(python_path) then
              return python_path
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
  use "rebelot/kanagawa.nvim"

  -- misc --------------------------------------------------
  use "lukas-reineke/indent-blankline.nvim"

  use {
    "smjonas/snippet-converter.nvim",
    config = function()
      local template = {
        sources = {
          ultisnips = {
            vim.fn.stdpath("config") .. "/ultisnips",
          },
        },
        output = {
          vscode = {
            vim.fn.stdpath("config") .. "/vscode",
          }
        },
      }
      require("snippet_converter").setup {
        templates = { template },
      }
    end
  }

end)
