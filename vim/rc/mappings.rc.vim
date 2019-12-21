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
tnoremap <silent><Esc> <C-\><C-n>

" window
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <M->> <C-w>>
nnoremap <M-<> <C-w><
nnoremap <M-+> <C-w>+
nnoremap <M--> <C-w>-
nnoremap ]w <C-w>w
nnoremap [w <C-w>W
nnoremap Q <C-w>q
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
nnoremap ]t gt
nnoremap [t gT

" buffer
nnoremap ]b :<C-u>bn<CR>
nnoremap [b :<C-u>bp<CR>
command Q bd

" quickfix
nnoremap ]q :<C-u>cn<CR>
nnoremap [q :<C-u>cp<CR>

if exists('g:__QUICKFIX_TOGGLE__')
    finish
endif
let g:__QUICKFIX_TOGGLE__ = 1

function! ToggleQuickfix()
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif
endfunction
nnoremap <script> <silent><Space>q :call ToggleQuickfix()<CR>

" set current directory
nnoremap <Leader>. :lcd %:p:h<CR>

" open
nnoremap <silent><Leader>o :<C-u>!open %<CR>
vnoremap <silent><Leader>o "zy:<C-u>!open <C-r>z<CR>

" 行末までヤンク
nnoremap Y y$

" 空行を追加
nnoremap <Space><CR> o<Esc>

" 再描画
nnoremap <silent><C-l> :<C-u>nohlsearch<CR><C-l>

" visual mode でペーストしたときにヤンクしない
xnoremap <expr> p 'pgv"'.v:register.'y`>'

" カーソル下の単語をハイライト
nnoremap <silent><Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
xnoremap <silent><Space> mz:call <SID>set_vsearch()<CR>:set hlsearch<CR>`z

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
