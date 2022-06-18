return require("packer").startup(function()
  -- packer itself -----------------------------------------
  use "wbthomason/packer.nvim"

  -- lsp ---------------------------------------------------
  use {
    { "williamboman/nvim-lsp-installer" },
    {
      "neovim/nvim-lspconfig",
      after = "nvim-lsp-installer",
      config = function()
        require("nvim-lsp-installer").setup {}
        local lspconfig = require("lspconfig")
        lspconfig.sumneko_lua.setup {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim", "use" }
              }
            }
          }
        }
        lspconfig.pyright.setup {}
        lspconfig.gopls.setup {}
      end
    }
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  -- use {
  --   "glepnir/lspsaga.nvim",
  --   config = function()
  --     require("lspsaga").init_lsp_saga {
  --       use_saga_diagnostic_sign = true,
  --       error_sign = "",
  --       warn_sign = "",
  --       hint_sign = "",
  --       infor_sign = "",
  --     }
  --   end
  -- }

  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup {}
    end
  }

  -- completion --------------------------------------------
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      cmp.setup {
        mapping = cmp.mapping.preset.insert({
          ["<c-b>"] = cmp.mapping.scroll_docs(-4),
          ["<c-f>"] = cmp.mapping.scroll_docs(4),
          -- ["<c-;>"] = cmp.mapping.complete(),
          ["<c-e>"] = cmp.mapping.abort(),
          ["<cr>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = {
          format = lspkind.cmp_format {
            mode = "symbol",
            maxwidth = 50,
          }
        }
      }
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "cmdline" },
          { name = "path" },
        }
      })
      -- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    end
  }

  -- editing -----------------------------------------------
  use "machakann/vim-sandwich"

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {}
    end
  }

  use "L3MON4D3/LuaSnip"

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
    requires = "nvim-lua/plenary.nvim"
  }

  -- file explorer -----------------------------------------
  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup {}
    end
  }

  -- status line -------------------------------------------
  use {
    "nvim-lualine/lualine.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("lualine").setup {
        options = { theme = "auto" }
      }
    end
  }

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

  -- colorscheme -------------------------------------------
  use {
    -- Please consider the experience with this plug-in as experimental until Tree-Sitter support in Neovim is stable!
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = "all"
      }
    end
  }
  use "folke/tokyonight.nvim"
  use "rebelot/kanagawa.nvim"

  -- misc --------------------------------------------------
  use "lukas-reineke/indent-blankline.nvim"
end)
