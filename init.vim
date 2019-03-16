"     __  __           _       _ _             _
"    |  \/  |_   _    (_)_ __ (_) |_    __   _(_)_ __ ___
"    | |\/| | | | |   | | '_ \| | __|   \ \ / / | '_ ` _ \
"    | |  | | |_| |   | | | | | | |_  _  \ V /| | | | | | |
"    |_|  |_|\__, |   |_|_| |_|_|\__|(_)  \_/ |_|_| |_| |_|
"            |___/

"-----------------------
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim.git' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml_dir = expand('~/.config/nvim')
    let s:toml = s:toml_dir . '/dein.toml'
    let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    "call dein#update, call dein#clear_state

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif
" takes time; update manually
" if dein#check_update()
"     call dein#update()
" endif
"call map(dein#check_clean(), "delete(v:val, 'rf')")
filetype plugin indent on
"------------------------

" appearance
set number
set nowrap
set breakindent
set list
set listchars=tab:»-,trail:-,nbsp:+
set laststatus=2
"set cursorline

" tab
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
set fileformats=unix,dos,mac

" search
set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" clipboard
set clipboard+=unnamedplus

" buffer
set hidden

" remap/shortcut
nnoremap j gj
nnoremap k gk
nnoremap vv v$h
nnoremap <Left> <C-w>h
nnoremap <Down> <C-w>j
nnoremap <Up> <C-w>k
nnoremap <Right> <C-w>l

" TODO:
" * session util
" * debugger
" * language server protocol
" * abbreviation
" * clean init.vim
