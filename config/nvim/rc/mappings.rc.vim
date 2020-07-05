" カーソル移動 {{{
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap H ^
nnoremap L g_
vnoremap H ^
vnoremap L g_

inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-h> <BS>
inoremap <C-k> <C-o>D<Right>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-e> <End>
" }}}

" 誤爆するキーを無効化 {{{
nnoremap Q <Nop>
nnoremap <F1> <Nop>
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

" ウィンドウ操作のprefixをsに割り当てる {{{
nnoremap s <C-w>
" }}}

" タブ移動 {{{
nnoremap <silent> ]t gt
nnoremap <silent> [t gT
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
    cwindow
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

" 空行を追加 {{{
nnoremap <Space><CR> o<Esc>
" }}}

" 再描画 {{{
nmap <silent> <C-l> :<C-u>nohlsearch<CR>:redraw<CR>
" }}}

" TERMINALモード時にEscでNORMALに復帰する {{{
tnoremap <silent> <Esc> <C-\><C-n>
" }}}

" 行番号の相対表示をトグル {{{
nnoremap <Space>0 :<C-u>setlocal relativenumber!<CR>
" }}}

" 選択範囲に.で繰り返しコマンド実行する {{{
vnoremap . :normal .<CR>
" }}}

" カーソル下の単語をハイライト {{{
nnoremap <silent> <C-h> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
xnoremap <silent> <C-h> mz:call <SID>set_vsearch()<CR>:set hlsearch<CR>`z

" カーソル下の単語をハイライトして置換
nmap <C-s> <C-h>:%s/<C-r>///g<Left><Left>
xmap <C-s> <C-h>:%s/<C-r>///g<Left><Left>
function! s:set_vsearch()
    silent normal gv"zy
    let @/ = '\V' . substitute(escape(@z, '/\'), '\n', '\\n', 'g')
endfunction
" }}}

" grep(お試し) {{{
nnoremap <Space>sg :<C-u>silent grep!<Space>
" }}}
