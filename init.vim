"     __  __           _       _ _             _
"    |  \/  |_   _    (_)_ __ (_) |_    __   _(_)_ __ ___
"    | |\/| | | | |   | | '_ \| | __|   \ \ / / | '_ ` _ \ 
"    | |  | | |_| |   | | | | | | |_  _  \ V /| | | | | | |
"    |_|  |_|\__, |   |_|_| |_|_|\__|(_)  \_/ |_|_| |_| |_|
"            |___/

"-----------------------
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible
endif

if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " Add or remove your plugins here:
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('itchyny/lightline.vim')
  call dein#add('t9md/vim-textmanip') " move text
  call dein#add('bronson/vim-trailing-whitespace') " FixWhitespace
  call dein#add('scrooloose/nerdtree') " file explore
  call dein#add('scrooloose/syntastic') " static syntax check
  call dein#add('tpope/vim-surround') " extends text object
  call dein#add('tpope/vim-abolish') " smart replace
  call dein#add('nelstrom/vim-visual-star-search') " extends */# search

  call dein#add('mattn/emmet-vim') " tag creator
  call dein#add('iwataka/minidown.vim') " markdown preview
  call dein#add('aklt/plantuml-syntax') " plantuml sntax
  call dein#add('dag/vim2hs') " haskell sntax
  " call dein#add('eagletmt/ghcmod-vim') " haskell static analyzer
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
call map(dein#check_clean(), "delete(v:val, 'rf')")
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
set nowrap
set list
set listchars=tab:»-

" lightline
set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }

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

" FixWhitespace
autocmd BufWritePre * :FixWhitespace

" denite
nnoremap [denite]    <Nop>
nmap     <Space>u [denite]

nnoremap <silent> [denite]d :<C-u>DeniteBufferDir file file:new<CR>
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
nnoremap <silent> [denite]f :<C-u>Denite file<CR>
nnoremap <silent> [denite]r :<C-u>Denite file_rec<CR>
nnoremap <silent> [denite]l :<C-u>Denite line<CR>
nnoremap <silent> [denite]g :<C-u>Denite -auto-preview grep<CR>

" like unite
call denite#custom#option('default', 'prompt', '>')
call denite#custom#option('default', 'direction', 'top')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" deoplete
let g:deoplete#eneble_at_startup = 1

" syntastic
let g:syntastic_python_checkers = ['pylint']
