set encoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac
filetype plugin indent on
syntax enable
set smartindent
set expandtab tabstop=2 shiftwidth=2
set hlsearch incsearch ignorecase smartcase wrapscan
set wildmenu
set ruler number
set hidden
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
vnoremap . :normal .<CR>
