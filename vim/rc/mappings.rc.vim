"================================================================================
" key mappings
"================================================================================

" カーソル移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-h> <BS>
inoremap <C-k> <C-o>D<Right>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

nnoremap <Space>0 :<C-u>setlocal relativenumber!<CR>

" 選択系
nnoremap vv v$h
vnoremap < <gv
vnoremap > >gv

" 行を移動
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

" ESC
" tnoremap <silent> <Esc> <C-\><C-n>
" terminalの挙動は上のが正しいけど、fzfをEscで終了するために下のようにする
tnoremap <silent> <Esc> <C-c>

" window
nmap s <C-w>
" map s <Nop>
" nnoremap sh <C-w>h
" nnoremap sj <C-w>j
" nnoremap sk <C-w>k
" nnoremap sl <C-w>l
" nnoremap Q <C-w>q

" ウィンドウ操作リファレンス
" <C-w> s
" <C-w> v
" <C-w> r
" <C-w> =
" <C-w> q
" <C-w> o
" <C-w> H,J,K,L

" tab
nnoremap <M-t> :<C-u>tab split<CR>
nnoremap <silent> ]t gt
nnoremap <silent> [t gT

" buffer
nnoremap <silent> ]b :<C-u>bn<CR>
nnoremap <silent> [b :<C-u>bp<CR>
command Q bd

" quickfix
nnoremap <silent> ]q :<C-u>cn<CR>
nnoremap <silent> [q :<C-u>cp<CR>

function! ToggleQuickfix()
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif
endfunction
nnoremap <script> <silent> <Space>q :call ToggleQuickfix()<CR>

" set current directory
nnoremap <Leader>. :lcd %:p:h<CR>

" open
nnoremap <silent> <Leader>o :<C-u>!open %<CR>
vnoremap <silent> <Leader>o "zy:<C-u>!open <C-r>z<CR>

" 行末までヤンク
nnoremap Y y$

" 空行を追加
nnoremap <Space><CR> o<Esc>

" 再描画
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" visual mode でペーストしたときにヤンクしない
xnoremap <expr> p 'pgv"'.v:register.'y`>'

nnoremap <Space>w viw

" カーソル下の単語をハイライト
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
xnoremap <silent> <Space> mz:call <SID>set_vsearch()<CR>:set hlsearch<CR>`z

" カーソル下の単語をハイライトして置換
nmap ? <Space><Space>:%s/<C-r>///g<Left><Left>
xmap ? <Space>:%s/<C-r>///g<Left><Left>
function! s:set_vsearch()
  silent normal gv"zy
  let @/ = '\V' . substitute(escape(@z, '/\'), '\n', '\\n', 'g')
endfunction


" free
" normal mode
" <C-h>
" <C-n>
" <C-j>
" <C-k>
" S
" X
" -
" _
