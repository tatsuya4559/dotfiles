"==========================================
" デフォルト値の変更
"==========================================

" 文字コード {{{
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac
" }}}

" 記号の表示崩れを防ぐ {{{
set ambiwidth=double
" }}}

" ステータスライン設定 {{{
set laststatus=2
set statusline=%f%m%h%r%w\ %<%=%(%l,%v\ %)
" }}}

" インデント設定 {{{
set smartindent
set breakindent
set expandtab
set tabstop=2
set shiftwidth=2
" }}}

" 検索設定 {{{
set incsearch
set ignorecase
set smartcase
set hlsearch
set wrapscan
" }}}

" バックスペースとCtrl+hで削除を有効にする {{{
set backspace=2
" }}}

" wildmenu有効化 {{{
set wildmenu
" }}}

" アイドル状態になる時間 {{{
set updatetime=100
" }}}

" ミュート {{{
set belloff=all
" }}}

" 不可視文字の表示 {{{
set list
set listchars=tab:»-,trail:-,nbsp:+,extends:»,precedes:«
" }}}

" スワップファイルを作成しない {{{
set noswapfile
" }}}

" ウィンドウサイズの自動調整を無効化 {{{
set noequalalways
" }}}

" 右にsplitする {{{
set splitright
" }}}

" 行番号を表示 {{{
set number
" set relativenumber
" }}}

" テキストを折り返さない {{{
" set nowrap
" }}}

" スクロール設定 {{{
" set scrolloff=8
" set sidescrolloff=16
set sidescroll=1
" }}}

" 日本語表示を抑制 {{{
language C
" }}}

" マウスを有効化 {{{
set mouse=a
" }}}

" コマンドラインからコマンドラインウィンドウを開く {{{
execute 'set cedit=\<C-c>'
" }}}

" バッファを保存しなくても切り替えられるようにする {{{
set hidden
" }}}

" ファイルの変更を自動読込 {{{
set autoread
augroup AutoReadChecktime
  autocmd!
  autocmd FocusGained * checktime
augroup END
" }}}

" terminal設定 {{{
set sh=bash
augroup Term
  autocmd!
  autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
augroup END
" }}}

" undo設定 {{{
set undolevels=1000
if has('persistent_undo')
  set undodir=./.vim/undo,~/.vim/undo
  augroup SaveUndoFile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif
" }}}

