let s:vimplug_file = expand('~/.local/share/nvim/site/autoload/plug.vim')
if !filereadable(s:vimplug_file)
  execute 'silent !curl -fLo ' .
        \ s:vimplug_file .
        \ ' --create-dirs' .
        \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
else
  call plug#begin('~/.local/share/nvim/plugged')

  " Syntax highlight
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'peitalin/vim-jsx-typescript'

  " Colorscheme
  Plug 'arcticicestudio/nord-vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'yasukotelin/shirotelin'

  " Text edit
  Plug 'haya14busa/vim-asterisk'
  Plug 'jiangmiao/auto-pairs'
  Plug 'machakann/vim-sandwich'
  Plug 'markonm/traces.vim'
  Plug 'thinca/vim-qfreplace'
  Plug 'tpope/vim-commentary'

  " File explore
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'cocopon/vaffle.vim'
  Plug 'ap/vim-buftabline'

  " Language support
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'
  Plug 'pechorin/any-jump.vim' " cocでジャンプできないpythonのため
  Plug 'SirVer/ultisnips'
  Plug 'mattn/emmet-vim'
  Plug 'AndrewRadev/tagalong.vim'
  Plug 'rust-lang/rust.vim'

  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive' " rhubarbが依存しているから
  Plug 'tpope/vim-rhubarb' " hub browseしか使ってない

  " Utils
  Plug 'AndrewRadev/linediff.vim'
  Plug 'vim-jp/vimdoc-ja'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'vim-test/vim-test'
  Plug 'benmills/vimux' " vim-testをtmuxで実行するため

  " DB
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'

  call plug#end()
endif
