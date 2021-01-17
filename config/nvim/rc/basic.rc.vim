" 文字コード
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac

" インデント設定
set smartindent
set breakindent
set expandtab
set tabstop=2
set shiftwidth=2

" 検索設定
" inccommand has bug (2020/10/05)
" set inccommand=nosplit
set ignorecase
set smartcase

" 不可視文字の表示
set list
set listchars=tab:▸\ ,trail:-,nbsp:+

" スワップファイルを作成しない
set noswapfile

" 行番号を表示
set number

" 日本語表示を抑制
language C

" コマンドラインからコマンドラインウィンドウを開く
execute 'set cedit=\<C-c>'

" バッファを保存しなくても切り替えられるようにする
set hidden

" ファイルの変更を自動読込
autocmd MyAutoCmd FocusGained,BufEnter * checktime

" undo設定
set undolevels=1000
set undodir=~/.local/share/nvim/undo
set undofile

" 縦棒のカーソルだと見えなくなる場合がある
set guicursor=
