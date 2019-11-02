"   __  ___       _      _ __        _
"  /  |/  /_ __  (_)__  (_) /_ _  __(_)_ _
" / /|_/ / // / / / _ \/ / __/| |/ / /  ' \
"/_/  /_/\_, / /_/_//_/_/\__(_)___/_/_/_/_/
"       /___/

"================================================================================
" 方針
" vimはプラグイン管理に消耗したくないから、最小限のものだけ入れておく。
" 各言語別の補完や、デバッグなどはIDEに任せる。
" InteriJのプラグインがない言語はvimでどうにかする。
"================================================================================

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
    " 汎用プラグイン
    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('itchyny/lightline.vim')
    call dein#add('scrooloose/nerdtree')
    call dein#add('thinca/vim-quickrun')
    "call dein#add('jsfaint/gen_tags.vim')

    " git
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

    " 外観
    call dein#add('altercation/vim-colors-solarized')

    " テキスト操作系
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('tpope/vim-abolish')
    call dein#add('nelstrom/vim-visual-star-search')
    call dein#add('machakann/vim-sandwich')
    call dein#add('mattn/emmet-vim')

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
colorscheme evening
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
source mappings.rc.vim

" plugin settings
" -------------------------------------------------------------------------------

"================================================================================
" denite
"================================================================================
nnoremap [denite] <Nop>
nmap <C-j> [denite]

" 再帰無しでファイル検索
nnoremap <silent> [denite]f :<C-u>Denite file -highlight-mode-insert=Search<CR>
" プロジェクト内のファイル検索
nnoremap <silent> [denite]r :<C-u>Denite file_rec -highlight-mode-insert=Search<CR>
" バッファに展開中のファイル検索
nnoremap <silent> [denite]b :<C-u>Denite buffer -highlight-mode-insert=Search<CR>
" ファイル内の関数/クラス等の検索
nnoremap <silent> [denite]o :<C-u>Denite outline -highlight-mode-insert=Search<CR>
" バッファに展開中の行を検索
nnoremap <silent> [denite]l :<C-u>Denite line -highlight-mode-insert=Search<CR>

nnoremap <silent> [denite]g :<C-u>Denite -auto-preview grep<CR>

"call denite#custom#option('default', 'prompt', '>')
" 上下移動を<C-n>, <C-p>
call denite#custom#map('normal', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('normal', '<C-p>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
" 入力履歴移動を<C-j>, <C-k>
call denite#custom#map('insert', '<C-j>', '<denite:assign_next_text>')
call denite#custom#map('insert', '<C-k>', '<denite:assign_previous_text>')
" 横割りオープンを`<C-s>`
call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>')
" 縦割りオープンを`<C-v>`
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>')
" タブオープンを`<C-t>`
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>')

" file_rec検索時にfuzzymatchを有効にし、検索対象から指定のファイルを除外
call denite#custom#source(
    \ 'file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'])

" 検索対象外のファイル指定
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

"================================================================================
" deoplete
"================================================================================
let g:deoplete#eneble_at_startup = 1

" FixWhitespace
autocmd BufWritePre * :FixWhitespace

"================================================================================
" gen_tags
"================================================================================
"let g:gen_tags#ctags_auto_gen = 1
"let g:gen_tags#gtags_auto_gen = 1

"================================================================================
" nerdtree
"================================================================================
map <Leader>e :NERDTreeToggle<CR>

"================================================================================
" fugitive
"================================================================================
nmap [fugitive] <Nop>
map <Leader>g [fugitive]
nmap <silent> [fugitive]s :<C-u>Gstatus<CR>
nmap <silent> [fugitive]d :<C-u>Gdiff<CR>
nmap <silent> [fugitive]b :<C-u>Gblame<CR>
nmap <silent> [fugitive]l :<C-u>Glog<CR>


" TODO:
" * session util
" * abbreviation
