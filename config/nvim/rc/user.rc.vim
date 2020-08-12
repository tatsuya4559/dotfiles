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
nnoremap j gj
xnoremap j gj
nnoremap k gk
xnoremap k gk

noremap! <C-b> <Left>
noremap! <C-f> <Right>
noremap! <C-e> <End>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-d> <Del>
cnoremap <C-a> <Home>
" }}}

" カラースキーム迷うなあ {{{
if exists('&termguicolors')
  set termguicolors
endif
colorscheme nord

function s:toggle_color()
  if g:colors_name !=# 'nord'
    execute 'colorscheme nord'
  else
    execute 'colorscheme iceberg'
    set background=light
  endif
endfunction
nnoremap <silent> <F3> :<C-u>call <SID>toggle_color()<CR>
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
vnoremap < <gv
vnoremap > >gv
" }}}

" 行を移動 {{{
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]
" }}}

" terminal {{{
tnoremap <Esc> <C-\><C-n>
tnoremap <silent> <C-w> <C-\><C-n><C-w>
augroup TermCmd
  autocmd!
  autocmd WinEnter,BufEnter term://* startinsert
augroup END
" }}}

" ウィンドウ操作のprefixをsに割り当てる {{{
nnoremap s <C-w>
" }}}

" ウィンドウのリサイズ {{{
nnoremap <S-Left> <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up> <C-w>+
nnoremap <S-Down> <C-w>-
" }}}

" バッファ移動 {{{
nnoremap <silent> ]b :<C-u>bn<CR>
nnoremap <silent> [b :<C-u>bp<CR>
" }}}

" 横スクロール {{{
nnoremap <silent> <Right> zl
nnoremap <silent> <Left> zh
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
  autocmd QuickFixCmdPost vimgrep,grep,grepadd,make if len(getqflist()) != 0 | cwindow 8 | endif
augroup END
" }}}

" 外部grepをカスタマイズ {{{
if executable('rg')
  let &grepprg = 'rg --vimgrep'
  let &grepformat = '%f:%l:%c:%m'
elseif executable('git')
  let &grepprg = 'git grep -I --no-color --line-number --column'
  let &grepformat = '%f:%l:%c:%m'
endif

nnoremap sg :<C-u>silent grep!<Space>
nnoremap ga :<C-u>silent grepadd!<Space>
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

" 設定のトグル {{{
nnoremap [switch] <Nop>
nmap <Space>s [switch]
nnoremap [switch]w :<C-u>setlocal wrap! wrap?<CR>
nnoremap [switch]l :<C-u>setlocal list! list?<CR>
nnoremap [switch]r :<C-u>setlocal relativenumber! relativenumber?<CR>
nnoremap [switch]b :<C-u>call <SID>toggle_background()<CR>

function s:toggle_background()
  let bg_color = &background == 'light' ? 'dark' : 'light'
  execute 'set background=' . bg_color
endfunction
" }}}

" 選択範囲に.で繰り返しコマンド実行する {{{
vnoremap . :normal .<CR>
" }}}

" 置換 vim-asteriskに依存 {{{
nmap c* *cgn

noremap [substitute] <Nop>
map gs [substitute]
nnoremap [substitute]s :%s/\v//<Left><Left>
nnoremap [substitute]. :s/\v//<Left><Left>
nmap [substitute]* *:%s/<C-r>///g<Left><Left>

vnoremap [substitute]s :s/\v//<Left><Left>
vmap [substitute]* *:%s/<C-r>///g<Left><Left>
" }}}

" tigを開く {{{
" neotermの最後に使ったterminalとしてカウントされたくないから
" 普通のterminalコマンドで開く
function! OpenTig()
  let s:tig_bufname = bufname('term://*:tig')
  if bufexists(s:tig_bufname)
    let tig_winnr = bufwinnr(s:tig_bufname)
    if tig_winnr >= 0
      execute tig_winnr . 'wincmd w'
    else
      execute 'buffer ' . s:tig_bufname
    endif
  else
    execute 'terminal tig'
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

" tig内でvimを開くときにネストしない {{{
" https://github.com/mhinz/neovim-remote
if executable('nvr')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  augroup GIT
    autocmd!
    autocmd FileType gitcommit,gitrebase set bufhidden=delete
    autocmd WinEnter,BufEnter term://*:tig startinsert
  augroup END
endif
" }}}

" 行末の空白を削除 {{{
command! -range=% FixWhitespaces :<line1>,<line2>s/\s\+$//g
" }}}

" ファイルパスをコピー {{{
command! CopyPath :let @+ = expand('%:p')
command! CopyFilename :let @+ = expand('%:t')
" }}}

" awk {{{
function! AwkPrint(line1, line2, ...)
  let args = map(copy(a:000), { _, v -> '$' . v })
  execute a:line1 ',' a:line2 "!awk '{print " join(args, ',') "}'"
endfunction
command! -range -nargs=+ Awk :call AwkPrint(<line1>, <line2>, <f-args>)
" }}}

" abbreviations {{{
:cabbrev sg silent grep!
:cabbrev ga silent grepadd!
:cabbrev windi windo diffthis
:cabbrev gd Gvdiffsplit
:cabbrev gb Gbrowse
:cabbrev ld Linediff
:cabbrev ggl SearchByGoogle
:cabbrev JO r!jo -p
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
        \ "normal! " . n . "\<C-e>" . n . "j" :
        \ "normal! " . n . "\<C-y>" . n . "k"
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

" Zoom Window {{{
function! ToggleZoom()
  if exists('t:unzoom_cmd')
    " FIXME: コマンド通りに復元されない場合がある
    " vimのバグ??
    execute t:unzoom_cmd
    unlet t:unzoom_cmd
  else
    let t:unzoom_cmd = winrestcmd()
    wincmd _
    wincmd |
  endif
endfunction
nnoremap <silent> <Space>z :call ToggleZoom()<CR>
" }}}

" Google it {{{
function! s:search_by_google(...) abort
  if empty(a:000)
    return
  endif
  let url = shellescape('https://www.google.com/search?q=' . join(a:000, '+'))
  call system('open ' . url)
endfunction
command! -nargs=* SearchByGoogle call s:search_by_google(<f-args>)
nnoremap <silent> <Space>g :SearchByGoogle <C-r>=expand('<cword>')<CR><CR>
vnoremap <silent> <Space>g "zy:SearchByGoogle <C-r>z<CR>
" }}}
