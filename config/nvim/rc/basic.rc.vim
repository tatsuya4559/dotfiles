" disable default plugins {{{
let g:loaded_2html_plugin = 1
let g:loaded_man = 1
" }}}

" 文字コード {{{
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac
" }}}

" ステータスライン設定 {{{
set laststatus=2 " default on neovim
" }}}

" インデント設定 {{{
set smartindent
set breakindent
set expandtab
set tabstop=2
set shiftwidth=2
" }}}

" 検索設定 {{{
set incsearch " default on neovim
" inccommand has bug (2020/10/05)
" set inccommand=nosplit
set ignorecase
set smartcase
set hlsearch " default on neovim
set wrapscan " default on neovim
" }}}

" バックスペースとCtrl+hで削除を有効にする {{{
set backspace=2 " default on neovim
" }}}

" wildmenu有効化 {{{
set wildmenu " default on neovim
" }}}

" アイドル状態になる時間 {{{
set updatetime=100
" }}}

" ミュート {{{
set belloff=all " default on neovim
" }}}

" 不可視文字の表示 {{{
set list
set listchars=tab:▸\ ,trail:-,nbsp:+
" }}}

" スワップファイルを作成しない {{{
set noswapfile
" }}}

" 右にsplitする {{{
set splitright
" }}}

" 行番号を表示 {{{
set ruler " default on neovim
set number
" set relativenumber
" }}}

" スクロール設定 {{{
set scrolloff=3
set sidescroll=1
" }}}

" 日本語表示を抑制 {{{
language C
" }}}

" マウスを有効化 {{{
set mouse=nvr
" }}}

" コマンドラインからコマンドラインウィンドウを開く {{{
execute 'set cedit=\<C-c>'
" }}}

" バッファを保存しなくても切り替えられるようにする {{{
set hidden
" }}}

" ファイルの変更を自動読込 {{{
set autoread " default on neovim
augroup AutoReadChecktime
  autocmd!
  autocmd FocusGained,BufEnter * checktime
augroup END
" }}}

" undo設定 {{{
set undolevels=1000
set undodir=~/.local/share/nvim/undo
set undofile
" }}}

" 縦棒のカーソルだと見えなくなる場合がある {{{
set guicursor=
" }}}
