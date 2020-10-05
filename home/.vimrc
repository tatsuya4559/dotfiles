" minimal settings
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac
set laststatus=2
filetype plugin indent on
syntax enable
set smartindent
set breakindent
set expandtab
set tabstop=2
set shiftwidth=2
set incsearch
set ignorecase
set smartcase
set hlsearch
set wrapscan
set clipboard+=unnamed
set backspace=2
set wildmenu
set list
set listchars=tab:»-,trail:-,nbsp:+
set number
set ruler
set hidden
nnoremap <silent> ]q :<C-u>cn<CR>
nnoremap <silent> [q :<C-u>cp<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
vnoremap . :normal .<CR>
nnoremap <C-p> :<C-u>e **/*
nnoremap <Space>b :<C-u>b *
nnoremap <Space>e :Ex<CR>

augroup GrepCmd
    autocmd!
    au QuickFixCmdPost vimgrep,grep,grepadd,make if len(getqflist()) != 0 | cwindow | endif
augroup END

nnoremap s <C-w>
