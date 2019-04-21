"   __  ___       _      _ __        _
"  /  |/  /_ __  (_)__  (_) /_ _  __(_)_ _
" / /|_/ / // / / / _ \/ / __/| |/ / /  ' \
"/_/  /_/\_, / /_/_//_/_/\__(_)___/_/_/_/_/
"       /___/

"================================================================================
" dein settings
"================================================================================
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

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
    call dein#add('itchyny/lightline.vim')
    call dein#add('altercation/vim-colors-solarized')
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('tpope/vim-abolish')
    call dein#add('nelstrom/vim-visual-star-search')
    call dein#add('machakann/vim-sandwich')

    call dein#add('mattn/emmet-vim')
    call dein#add('dag/vim2hs') " haskell
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
call map(dein#check_clean(), "delete(v:val, 'rf')")
filetype plugin indent on


"================================================================================
" basic settings
"================================================================================
"colors
colorscheme desert
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }

" appearance
set number
set nowrap
set breakindent
set list
set listchars=tab:»-,trail:-,nbsp:+

" tab
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

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
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" clipboard
set clipboard+=unnamedplus

" buffer
set hidden


"================================================================================
" keymaps
"================================================================================
" remap/shortcut
nnoremap j gj
nnoremap k gk
nnoremap vv v$h
nnoremap <Left> <C-w>h
nnoremap <Down> <C-w>j
nnoremap <Up> <C-w>k
nnoremap <Right> <C-w>l

"================================================================================
" plugin settings
"================================================================================
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

" FixWhitespace
autocmd BufWritePre * :FixWhitespace

" TODO:
" * session util
" * debugger
" * language server protocol
" * abbreviation
