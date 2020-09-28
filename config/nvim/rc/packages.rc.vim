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
  Plug 'evanleck/vim-svelte', {'branch': 'main'}

  " Colorscheme
  Plug 'arcticicestudio/nord-vim'
  Plug 'yasukotelin/shirotelin'

  " Text edit
  Plug 'haya14busa/vim-asterisk'
  Plug 'justinmk/vim-sneak'
  Plug 'jiangmiao/auto-pairs'
  Plug 'machakann/vim-sandwich'
  Plug 'markonm/traces.vim'
  Plug 'thinca/vim-qfreplace'
  Plug 'tpope/vim-commentary'

  " File explore
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'cocopon/vaffle.vim'

  " Language support
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'
  Plug 'pechorin/any-jump.vim' " cocでジャンプできないpythonのため
  Plug 'SirVer/ultisnips'
  Plug 'AndrewRadev/tagalong.vim'
  Plug 'mattn/vim-goimpl'
  Plug 'mattn/vim-goimports'
  Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive' " rhubarbが依存しているから
  Plug 'tpope/vim-rhubarb' " hub browseしか使ってない

  " Utils
  Plug 'AndrewRadev/linediff.vim'
  Plug 'vim-jp/vimdoc-ja'
  Plug 'vim-test/vim-test'
  Plug 'kassio/neoterm'

  call plug#end()
endif
