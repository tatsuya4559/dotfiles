let s:vimplug_file = expand('~/.local/share/nvim/site/autoload/plug.vim')
if !filereadable(s:vimplug_file)
  execute 'silent !curl -fLo ' .
        \ s:vimplug_file .
        \ ' --create-dirs' .
        \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
else
  call plug#begin('~/.local/share/nvim/plugged')

  " Colorscheme
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'yasukotelin/shirotelin'
  Plug 'arcticicestudio/nord-vim'

  " Text edit
  Plug 'markonm/traces.vim'
  Plug 'machakann/vim-sandwich'
  Plug 'bronson/vim-visual-star-search'
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'

  " File explore
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'cocopon/vaffle.vim'
  Plug 'ap/vim-buftabline'

  " Language support
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'pechorin/any-jump.vim' " cocでジャンプできないpythonのため
  Plug 'SirVer/ultisnips'
  Plug 'mattn/emmet-vim'
  Plug 'AndrewRadev/tagalong.vim'

  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'

  " Utils
  Plug 'AndrewRadev/linediff.vim'
  Plug 'vim-jp/vimdoc-ja'
  Plug 'christoomey/vim-tmux-navigator'

  " DB
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'

  call plug#end()
endif
