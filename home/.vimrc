" spartan settings
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac
filetype plugin indent on
syntax enable
set smartindent breakindent
set expandtab tabstop=4 shiftwidth=4
set hlsearch incsearch ignorecase smartcase wrapscan
set wildmenu
set laststatus=2
set ruler
set number
set hidden
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
vnoremap . :normal .<CR>
nnoremap <C-p> :<C-u>e **/*
nnoremap <Space>b :<C-u>b *
nnoremap <Space>e :Ex<CR>
nnoremap s <C-w>
