return require('packer').startup(function(use)
  -- packer itself -----------------------------------------
  -- TODO: lazyに乗り換える
  use 'wbthomason/packer.nvim'

  -- lsp ---------------------------------------------------
  use {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    {
      'neovim/nvim-lspconfig',
      config = function()
        require('mason').setup()
        require('mason-lspconfig').setup()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup {}
        lspconfig.pyright.setup {}
        lspconfig.gopls.setup {}
        lspconfig.tsserver.setup {}
        lspconfig.ocamllsp.setup {}
        lspconfig.bashls.setup {}
        lspconfig.terraformls.setup {}

        local function on_hover()
          if vim.bo.filetype == 'vim' or vim.bo.filetype == 'lua' then
            local cword = vim.fn.expand('<cword>')
            vim.cmd(string.format('help %s', cword))
          else
            vim.lsp.buf.hover()
          end
        end
        vim.o.omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })
        vim.keymap.set('n', '<space>d', '<cmd>TroubleToggle<cr>', { noremap = true })
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { noremap = true })
        vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, { noremap = true })
        vim.keymap.set('n', 'K', on_hover, { noremap = true })
        vim.api.nvim_create_user_command('Format', vim.lsp.buf.format, {})
      end
    }
  }

  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup {}
    end
  }

  use {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup {
        icons = false,
        fold_open = 'v',
        fold_closed = '>',
        signs = {
          error = 'E',
          warning = 'W',
          hint = 'H',
          information = 'I',
          other = '?',
        }
      }
    end
  }

  -- filer -------------------------------------------------
  use 'tatsuya4559/filer.vim'

  -- fuzzy finder ------------------------------------------
  use {
    -- TODO: 上下移動のmappingをctrlpに合わせてc-j, c-kにする
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          layout_strategy = 'vertical',
          mappings = {
            i = {
              ['<esc>'] = actions.close,
              ['<c-j>'] = actions.move_selection_next,
              ['<c-k>'] = actions.move_selection_previous,
            }
          },
        }
      }
      local builtin = require('telescope.builtin')
      local function ctrlp()
        local ok, result = pcall(builtin.git_files)
        if ok then
          return result
        end
        return builtin.find_files()
      end
      vim.keymap.set('n', '<c-p>', ctrlp, { noremap = true })
      vim.keymap.set('n', '<space>b', builtin.buffers, { noremap = true })
      vim.keymap.set('n', '<space>g', builtin.live_grep, { noremap = true })
      vim.keymap.set('n', '<space>w', builtin.grep_string, { noremap = true })
      vim.keymap.set('n', '<space>l', builtin.current_buffer_fuzzy_find, { noremap = true })
      vim.keymap.set('n', 'gd',  builtin.lsp_definitions, { noremap = true })
      vim.keymap.set('n', 'gr', builtin.lsp_references, { noremap = true })
      vim.keymap.set('n', 'gi', builtin.lsp_implementations, { noremap = true })
      vim.keymap.set('n', 'go', builtin.lsp_document_symbols, { noremap = true })
      vim.keymap.set('n', 'gs', builtin.lsp_dynamic_workspace_symbols, { noremap = true })
    end
  }

  use {
    'FeiyouG/commander.nvim',
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
      local commander = require('commander')
      commander.setup {
        integration = {
          telescope = {
            enable = true
          }
        }
      }
      vim.keymap.set('n', '<space>p', commander.show, { noremap = true })
      commander.add {
        {
          desc = 'reload init.lua',
          cmd = '<cmd>source $MYVIMRC<cr>',
        },
        {
          desc = 'edit alacritty.yaml',
          cmd = '<cmd>edit ~/.config/alacritty/alacritty.yml<cr>',
        },
        {
          desc = 'edit .tmux.conf',
          cmd = '<cmd>edit ~/.tmux.conf<cr>',
        },
        {
          desc = 'edit .aws/config',
          cmd = '<cmd>edit ~/.aws/config<cr>',
        },
        {
          -- https://github.com/yusukebe/gh-markdown-preview
          desc = 'preview markdown',
          cmd = '<cmd>terminal gh markdown-preview %<cr>',
        },
        {
          desc = 'git pull',
          cmd = '<cmd>Gina!! pull<cr>',
        },
        {
          desc = 'git checkout',
          cmd = '<cmd>Gina branch<cr>',
        },
        {
          desc = 'git add -p',
          cmd = '<cmd>Gina!! add -p<cr>',
        },
        {
          desc = 'git commit',
          cmd = '<cmd>Gina commit -v<cr>',
        },
        {
          desc = 'git push',
          cmd = '<cmd>Gina!! push -u<cr>',
        },
        {
          desc = 'gh pr create',
          cmd = '<cmd>!gh pr create -w<cr>',
        },
        {
          desc = 'gh repo view',
          cmd = '<cmd>!gh repo view -w<cr>',
        },
        {
          desc = 'circleci open',
          cmd = '<cmd>!circleci open<cr>',
        },
      }
    end
  }

  use {
    'ANGkeith/telescope-terraform-doc.nvim',
    requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-terraform-doc.nvim" },
    },
    config = function()
      require('telescope').load_extension('terraform_doc')
    end
  }

  -- git ---------------------------------------------------
  use {
    'lambdalisue/gina.vim',
    config = function()
      vim.keymap.set({'n', 'v'}, '<leader>gh', ':Gina browse --exact : <cr>')
      vim.keymap.set({'n', 'v'}, '<leader>gy', ':Gina browse --exact --yank : <cr>:let @+ = @"<cr>')
    end
  }

  use {
    'f-person/git-blame.nvim',
    config = function()
      require('gitblame').setup {
        enabled = false,
      }
      vim.keymap.set('n', '<leader>b', function() vim.cmd 'GitBlameToggle' end, { noremap = true })
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {}
    end
  }

  -- editing -----------------------------------------------
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        mapping = cmp.mapping.preset.insert({
          ['<c-x><c-o>'] = cmp.mapping.complete({}),
          ['<c-e>'] = cmp.mapping.abort(),
          ['<cr>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'vsnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }
    end
  }

  use 'machakann/vim-sandwich'

  use {
    'hrsh7th/vim-vsnip',
    config = function()
      vim.cmd [[
      let g:vsnip_snippet_dir = '~/.vim/vsnip/out'
      imap <expr> <tab> vsnip#expandable() ? '<plug>(vsnip-expand)' : '<tab>'
      imap <expr> <c-j> vsnip#jumpable(1) ? '<plug>(vsnip-jump-next)' : '<c-j>'
      imap <expr> <c-k> vsnip#jumpable(-1) ? '<plug>(vsnip-jump-prev)' : '<c-k>'
      ]]
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use 'itchyny/vim-qfedit'

  -- motion ------------------------------------------------
  use {
    'haya14busa/vim-edgemotion',
    config = function()
      vim.keymap.set('n', '<c-j>', '<plug>(edgemotion-j)')
      vim.keymap.set('n', '<c-k>', '<plug>(edgemotion-k)')
    end
  }

  use {
    'tkmpypy/chowcho.nvim',
    config = function()
      local function auto_chowcho()
        if vim.fn.winnr('$') <= 2 then
          vim.cmd 'wincmd w'
        else
          require('chowcho').run()
        end
      end
      vim.keymap.set('n', '<c-w><c-w>', auto_chowcho, { noremap = true })
      vim.keymap.set('n', '<c-w>w', auto_chowcho, { noremap = true })
    end
  }

  -- utility -----------------------------------------------
  use 'jghauser/mkdir.nvim'

  use {
    'thinca/vim-quickrun',
    config = function()
      vim.keymap.set('n', '<leader>r', '<plug>(quickrun)')
    end
  }

  use 'AndrewRadev/linediff.vim'

  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()
      vim.keymap.set({'n', 't'}, '<c-t>', '<cmd>ToggleTerm size=30 direction=horizontal name=desktop<cr>', { noremap = true })
    end
  }

  -- language specific -------------------------------------
  use 'mattn/emmet-vim'
  use 'mattn/vim-goimports'

  -- test --------------------------------------------------
  use {
    'nvim-neotest/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-go',
    },
    config = function()
      local neotest = require('neotest')
      neotest.setup {
        adapters = {
          require('neotest-python') {
            dap = { justMyCode = false },
            runner = 'pytest' -- can be a function to return dynamic value
          },
          require('neotest-go')
        }
      }
      vim.api.nvim_create_user_command('NeoTestFile', function() neotest.run.run(vim.fn.expand('%')) end, {})
      vim.api.nvim_create_user_command('NeoTestNearest', neotest.run.run, {})
      vim.api.nvim_create_user_command('NeoTestOutput', neotest.output.open, {})
      vim.api.nvim_create_user_command('NeoTestSummaryToggle', neotest.summary.toggle, {})
    end
  }

  -- colorscheme -------------------------------------------
  use {
    -- Please consider the experience with this plug-in as experimental until Tree-Sitter support in Neovim is stable!
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        ensure_installed = 'all'
      }
    end
  }

  use 'folke/tokyonight.nvim'

end)
