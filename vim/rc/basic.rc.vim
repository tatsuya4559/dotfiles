"================================================================================
" basic settings
"================================================================================
" appearance
set number
set nowrap
set breakindent
set list
set listchars=tab:»-,trail:-,nbsp:+

" search
set ignorecase
set smartcase
set hlsearch
set wrapscan
set incsearch
nmap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" tab
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" clipboard
set clipboard+=unnamedplus

" buffer
set hidden

" terminal
set sh=bash
autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
autocmd TermOpen * setlocal nonumber
