" 文字コード {{{
set encoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac
" }}}

" シンタックスを有効化 {{{
syntax enable
" }}}

" ステータスライン設定 {{{
set laststatus=2
set statusline=%f%m%h%r%w\ %<%=%(%l,%v\ %=[%{&fenc!=''?&fenc:&enc}]%)
" }}}

" カーソル行をハイライト {{{
" set cursorline
" }}}

" カラースキーム {{{
if exists('&termguicolors')
    set termguicolors
endif
colorscheme shirotelin
" }}}

" タブ設定 {{{
set smartindent
set breakindent
set expandtab " タブでスペース挿入
set tabstop=4 " タブの表示幅
set softtabstop=4 " <Tab>で挿入されるスペースの数
set shiftwidth=4 " 自動インデントのサイズ

" ファイルタイプ別のインデント設定 {{{
augroup FiletypeIndent
    autocmd!
    au Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    au Filetype css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    au Filetype javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    au Filetype yaml,toml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    au Filetype toml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END
" }}}

" 検索設定 {{{
set incsearch
set ignorecase
set smartcase
set hlsearch
set wrapscan
" }}}

" UNDO設定 {{{
set undolevels=1000
if has('persistent_undo')
    set undodir=./.vimundo,~/.vimundo
    augroup SaveUndoFile
        autocmd!
        autocmd BufReadPre ~/* setlocal undofile
    augroup END
endif
" }}}

" クリップボードを共有 {{{
set clipboard+=unnamedplus
" }}}

" バックスペースとCtrl+hで削除を有効にする {{{
set backspace=2
" }}}

" wildmenu有効化 {{{
set wildmenu
" }}}

" 描画改善 {{{
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

" 行番号を表示 {{{
set number
set relativenumber
" }}}

" テキストを折り返さない {{{
set nowrap
" }}}

" スクロール設定 {{{
" set scrolloff=8
set sidescroll=1
set sidescrolloff=16
" }}}

" 日本語表示を抑制 {{{
language C
" }}}

" コメント行から改行したときに自動コメントアウトしない {{{
" autocmd FileType * setlocal formatoptions-=ro
" }}}

" マウスを有効化 {{{
set mouse=a
" }}}

" バッファを保存しなくても切り替えられるようにする {{{
set hidden
" }}}

" terminal設定 {{{
set sh=bash
augroup Term
    autocmd!
    au WinEnter * if &buftype ==# 'terminal' | startinsert | endif
    au TermOpen * setlocal norelativenumber nonumber
augroup END
" }}}

" grep結果をQuickFixに送る {{{
augroup GrepCmd
    autocmd!
    au QuickFixCmdPost vim,grep if len(getqflist()) != 0 | cwindow | endif
augroup END
" }}}

" 外部grepをripgrepにする {{{
if executable('rg')
    let &grepprg = 'rg --vimgrep'
    set grepformat=%f:%l:%c:%m
endif
" grep 'pattern' path/ -i -tpy
" grep 'regex' -g src/*.py
" }}}

" abbreviation
:iabbrev bbash #!/bin/bash
:cabbrev sg silent grep!
:cabbrev be bufdo e
:cabbrev recache call dein#recache_runtimepath()
:cabbrev ar AsyncRun
:cabbrev as AsyncStop
:cabbrev gi Gina
