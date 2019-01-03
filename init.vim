"-----------------------
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible
endif

if !isdirectory(s:dein_repo_dir)
    execute '!git clone git@github.com:Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " Add or remove your pllugins here:
  call dein#add('Shougo/dein.vim') " package manager
  call dein#add('Shougo/deoplete.nvim') " auto complete
  call dein#add('altercation/vim-colors-solarized') " color scheme
  call dein#add('vim-airline/vim-airline') " cool status bar
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('t9md/vim-textmanip') " move text
  call dein#add('bronson/vim-trailing-whitespace') " FixWhitespace
  call dein#add('scrooloose/nerdtree') " file explore
  call dein#add('tpope/vim-surround') " extends text object
  call dein#add('tpope/vim-abolish') " smart replace
  call dein#add('nelstrom/vim-visual-star-search') " extends */# search

  call dein#add('mattn/emmet-vim') " tag creator
  call dein#add('iwataka/minidown.vim') " markdown preview
  call dein#add('aklt/plantuml-syntax') " plantuml sntax
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
"------------------------

" colors
call togglebg#map('<F5>')
syntax enable
set background=dark
colorscheme solarized
"set termguicolors
"let g:solarized_termcolors=256
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" appearance
set number
set cursorline
set list
set listchars=tab:»-
    " ,trail:*,eol:↲

" airline
set statusline=%F " filename
set statusline+=%m " modified
set statusline+=%r " readonly
set statusline+=%=
set statusline+=[ENC=%{&fileencoding}] " encoding
set statusline+=[LOW=%l/%L] " low num
set laststatus=2 " always print statusline
" write airline settings here
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" tab
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" encoding
set fileformats=unix,dos,mac
set fileencodings=ucs-bombs,utf-8,euc-jp,cp932

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

xmap <M-j> <Plug>(textmanip-move-down)
xmap <M-k> <Plug>(textmanip-move-up)
xmap <M-h> <Plug>(textmanip-move-left)
xmap <M-l> <Plug>(textmanip-move-right)

" for nerdtree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" use netrw
filetype plugin on

" autocmd
autocmd BufWritePre * :FixWhitespace

" use deoplete
let g:deoplete#eneble_at_startup = 1
