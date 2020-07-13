"==========================================
" ユーザ定義マッピング・コマンド
"==========================================

" 誤爆するキーを無効化 {{{
nnoremap Q <Nop>
nnoremap <F1> <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" }}}

" prefixにするキーを無効化 {{{
noremap s <Nop>
noremap <Space> <Nop>
" }}}

" カーソル移動 {{{
noremap j gj
noremap k gk

noremap H ^
noremap L g_

noremap! <C-b> <Left>
noremap! <C-f> <Right>
noremap! <C-e> <End>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-d> <Del>
cnoremap <C-a> <Home>
" }}}

" カラースキーム {{{
if exists('&termguicolors')
  set termguicolors
endif
colorscheme nord
" }}}

" クリップボードを共有 {{{
" thanks to monaqa
set clipboard=

noremap <Space>p "+p
noremap <Space>P "+P
noremap! <C-r><C-r> <C-r>"
noremap! <C-r><Space> <C-r>+

augroup YankToClipboard
  autocmd!
  autocmd TextYankPost * call <SID>copy_unnamed_to_plus(v:event.operator)
augroup END

function! s:copy_unnamed_to_plus(opr)
  " yank操作のときのみ+レジスタに内容を移す
  if a:opr ==# 'y'
    let @+ = @"
  endif
endfunction
" }}}

" vvで行末まで選択 {{{
nnoremap vv v$h
" }}}

" <, >で連続してインデント調整できるようにする {{{
nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv
" }}}

" 行を移動 {{{
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]
" }}}

" ウィンドウ操作のprefixをsに割り当てる {{{
nnoremap s <C-w>
" }}}

" バッファ移動 {{{
nnoremap <silent> ]b :<C-u>bn<CR>
nnoremap <silent> [b :<C-u>bp<CR>
nnoremap <silent> <Right> :<C-u>bn<CR>
nnoremap <silent> <Left> :<C-u>bp<CR>
nnoremap <Space>b :<C-u>b *
" }}}

" QuickFix移動 {{{
nnoremap <silent> ]q :<C-u>cn<CR>
nnoremap <silent> [q :<C-u>cp<CR>
" }}}

" QuickFixをトグル {{{
function! ToggleQuickfix()
  let l:nr = winnr('$')
  cwindow 8
  let l:nr2 = winnr('$')
  if l:nr == l:nr2
    cclose
  endif
endfunction
nnoremap <script><silent> <Space>q :call ToggleQuickfix()<CR>
" }}}

" grep, makeのの実行後にQuickFixを開く {{{
augroup QfCmd
  autocmd!
  autocmd QuickFixCmdPost vimgrep,grep,make if len(getqflist()) != 0 | cwindow 8 | endif
augroup END
" }}}

" 外部grepをカスタマイズ {{{
if executable('rg')
  let &grepprg = 'rg --vimgrep'
  set grepformat=%f:%l:%c:%m
elseif executable('git')
  let &grepprg = 'git grep -I --no-color --line-number --column'
  set grepformat=%f:%l:%c:%m
endif

nnoremap sg :<C-u>silent grep!<Space>
" }}}

" URLなどを開く {{{
nnoremap <silent> <Leader>o :<C-u>!open %<CR>
vnoremap <silent> <Leader>o "zy:<C-u>!open <C-r>z<CR>
" }}}

" 行末までヤンク {{{
nnoremap Y y$
" }}}

" 空行を追加 {{{
nnoremap <Space><CR> mzo<Esc>`z
" }}}

" 再描画でハイライトを消す {{{
nmap <silent> <C-l> :<C-u>nohlsearch<CR>:redraw<CR>
" }}}

" 行番号の相対表示をトグル {{{
nnoremap <Space>0 :<C-u>setlocal relativenumber!<CR>
" }}}

" 選択範囲に.で繰り返しコマンド実行する {{{
vnoremap . :normal .<CR>
" }}}

" カーソル下の単語をハイライト {{{
nnoremap <silent> <C-h> :call <SID>set_cword_to_search_reg()<CR>:set hlsearch<CR>
vnoremap <silent> <C-h> mz:call <SID>set_visual_to_search_reg()<CR>:set hlsearch<CR>`z
" }}}

" 置換 {{{
nnoremap cgw :call <SID>set_cword_to_search_reg()<CR>cgn

noremap [substitute] <Nop>
map gs [substitute]
nnoremap [substitute]s :%s/\v//<Left><Left>
nnoremap [substitute]. :s/\v//<Left><Left>
nnoremap [substitute]* :<C-u>%s/\V\<<C-r>=expand('<cword>')<CR>\>//<Left>

vnoremap [substitute]s :s/\v//<Left><Left>
vnoremap [substitute]* :call <SID>set_visual_to_search_reg()<CR>:%s/<C-r>///g<Left><Left>

function! s:set_cword_to_search_reg()
  let @/ = '\V\<' . expand('<cword>') . '\>'
endfunction

function! s:set_visual_to_search_reg()
  silent normal gv"zy
  let @/ = '\V' . substitute(escape(@z, '/\'), '\n', '\\n', 'g')
endfunction
" }}}

" tigを開く {{{
let s:tig_bufnr = -1
function! OpenTig()
  if bufexists(s:tig_bufnr)
    let tig_winnr = bufwinnr(s:tig_bufnr)
    if tig_winnr >= 0
      execute tig_winnr . 'wincmd w'
    else
      execute s:tig_bufnr 'buffer'
    endif
  else
    execute 'terminal tig'
    let s:tig_bufnr = bufnr('%')
    setlocal nonumber
    setlocal norelativenumber
    " Qでtigを閉じずにもとのバッファに戻る
    tnoremap <buffer> Q <C-\><C-n><C-^>
    tnoremap <buffer> <C-w> <C-\><C-n><C-w>
  endif
  startinsert
endfunction

nnoremap <Space>t :<C-u>call OpenTig()<CR>
" }}}

" 行末の空白を削除 {{{
command! -range=% FixWhitespaces :<line1>,<line2>s/\s\+$//g
" }}}

" ファイルパスをコピー {{{
command! CopyPath :let @+ = expand('%:p')
command! CopyFilename :let @+ = expand('%:t')
" }}}

" abbreviations {{{
:cabbrev sg silent grep!
:cabbrev windi windo diffthis
:cabbrev gd Gvdiffsplit
:cabbrev gb Gbrowse
:cabbrev ld Linediff
" }}}

" smooth scroll {{{
" thanks to cohama
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

" EscしたときにIMEをオフにする {{{
" FIXME: オフにしてくれるのはいいけどESCのレスポンスが遅くなって困る
if has('mac')
  set ttimeoutlen=1
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  inoremap <silent> <Esc> <Esc>:call system(g:imeoff)<CR>
  nnoremap <silent> <Esc> <Esc>:call system(g:imeoff)<CR>
endif
" }}}
