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

" URLなどを開く {{{
nnoremap <silent> <Leader>o :<C-u>!open %<CR>
vnoremap <silent> <Leader>o "zy:<C-u>!open <C-r>z<CR>
" }}}

" 行末までヤンク {{{
nnoremap Y y$
" }}}

" ペースト系 {{{
noremap <Space>p "+p
noremap <Space>P "+P
noremap! <C-r><C-r> <C-r>"
noremap! <C-r><Space> <C-r>+
" }}}

" 空行を追加 {{{
nnoremap <Space><CR> mzo<Esc>`z
" }}}

" 再描画 {{{
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

" grep(お試し) {{{
nnoremap sg :<C-u>silent grep!<Space>
" }}}

" tigを開く {{{
function! OpenTig()
  let tig_buf_name = bufname('term://*tig')
  if tig_buf_name == ''
    execute 'terminal tig'
    setlocal nonumber
    setlocal norelativenumber
    " Qでtigを閉じずにもとのバッファに戻る
    tnoremap <buffer> Q <C-\><C-n><C-^>
  else
    execute ':b ' . tig_buf_name
  endif
  startinsert
endfunction

nnoremap <Space>t :<C-u>call OpenTig()<CR>
" }}}
