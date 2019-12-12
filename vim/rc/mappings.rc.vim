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
tnoremap <silent> <Esc> <C-\><C-n>

" window
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" buffer
nnoremap <Space>; :<C-u>bn<CR>
nnoremap <Space>, :<C-u>bp<CR>

" set current directory
nnoremap <Leader>. :lcd %:p:h<CR>

" コマンドとして実行
vnoremap <Leader>x :!sh<CR>
nnoremap <Leader>x V:!sh<CR>

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
