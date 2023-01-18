set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac
filetype plugin indent on
syntax enable
set smartindent
set expandtab tabstop=2 shiftwidth=2
set hlsearch incsearch ignorecase smartcase wrapscan
set shortmess-=S
set backspace=2
set wildmenu
set list
set ruler
set hidden

" keymaps
nnoremap <silent> <c-l> :<c-u>nohlsearch<cr><c-l>
vnoremap . :normal .<cr>
nnoremap Y y$

" abbreviations
cabbrev w!! w !sudo tee > /dev/null %
