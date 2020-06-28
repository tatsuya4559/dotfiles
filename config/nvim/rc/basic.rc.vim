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
set tabstop=2 " タブの表示幅
set softtabstop=2 " <Tab>で挿入されるスペースの数
set shiftwidth=2 " 自動インデントのサイズ

" ファイルタイプ別のインデント設定
augroup FiletypeIndent
    autocmd!
    au Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    au Filetype java setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    au Filetype sql setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
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
    set undodir=./.vim/undo,~/.vim/undo
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
" set relativenumber
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
augroup END
" }}}

" 行末の空白を削除 {{{
command! -range=% FixWhitespaces :<line1>,<line2>s/\s\+$//g
" }}}

" ファイルパスをコピー {{{
command! CopyPath :let @+ = expand('%:p')
command! CopyFilename :let @+ = expand('%:t')
" }}}

" grep結果をQuickFixに送る {{{
augroup GrepCmd
    autocmd!
    au QuickFixCmdPost vim,grep if len(getqflist()) != 0 | cwindow | endif
augroup END
" }}}

" 外部grepをripgrepにする {{{
if executable('rg')
    set grepprg =rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
elseif executable('git')
    set grepprg=git\ grep\ -I\ --no-color\ --line-number\ --column
    set grepformat=%f:%l:%c:%m
endif
" #############################
" ripgrepの使い方:
" :grep 'pattern' path/ -i -tpy
" :grep 'regex' -g src/*.py
" #############################
" }}}

" abbreviations {{{
:cabbrev sg silent grep!
:cabbrev be bufdo e
:cabbrev windi windo diffthis
" }}}

" smooth scroll {{{
let s:scroll_time_ms = 100
let s:scroll_precision = 8
function! SmoothScroll(dir, windiv, factor)
  let cl = &cursorline
  let cc = &cursorcolumn
  set nocursorline nocursorcolumn
  let height = winheight(0) / a:windiv
  let n = height / s:scroll_precision
  if n <= 0
    let n = 1
  endif
  let wait_per_one_move_ms = s:scroll_time_ms / s:scroll_precision * a:factor
  let i = 0
  let scroll_command = a:dir == "down" ?
        \ "normal! " . n . "\<C-e>" . n ."j" :
        \ "normal! " . n . "\<C-y>" . n ."k"
  while i < s:scroll_precision
    let i = i + 1
    execute scroll_command
    execute "sleep " . wait_per_one_move_ms . "m"
    redraw
  endwhile
  let &cursorline = cl
  let &cursorcolumn = cc
endfunction
nnoremap <silent><expr> <C-d> v:count == 0 ? ":call SmoothScroll('down', 2, 1)\<CR>" : "\<C-d>"
nnoremap <silent><expr> <C-u> v:count == 0 ? ":call SmoothScroll('up', 2, 1)\<CR>" : "\<C-u>"
nnoremap <silent><expr> <C-f> v:count == 0 ? ":call SmoothScroll('down', 1, 2)\<CR>" : "\<C-f>"
nnoremap <silent><expr> <C-b> v:count == 0 ? ":call SmoothScroll('up', 1, 2)\<CR>" : "\<C-b>"
" }}}
