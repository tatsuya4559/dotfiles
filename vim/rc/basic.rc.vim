"================================================================================
" basic settings
"================================================================================
" appearance
set number
set nowrap
set breakindent
set list
set listchars=tab:»-,trail:-,nbsp:+
set updatetime=100
set conceallevel=0
let g:vim_json_syntax_conceal = 0

"colors
colorscheme gruvbox
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ }

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac

" search
set ignorecase
set smartcase
set hlsearch
set wrapscan
set incsearch

" tab
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" clipboard
set clipboard+=unnamedplus

" mouse
set mouse=a

" buffer
set hidden

" terminal
set sh=bash
autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
autocmd TermOpen * setlocal nonumber

" abbreviation
ia bbash #!/bin/bash

" TODO:
" * session util href="https://qiita.com/gorilla0513/items/838138004f86b66d5668"
