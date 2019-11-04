"================================================================================
" key mappings
"================================================================================
" Leader
let mapleader = "\<Space>"

" カーソル移動系
nnoremap H ^
nnoremap L $
nnoremap j gj
nnoremap k gk
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$<Right>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-h> <BS>
inoremap <C-d> <Del>
inoremap <C-k> <C-o>D<Right>
inoremap <C-u> <C-o>d^
inoremap <C-w> <C-o>db

" 選択系
nnoremap vv v$h
vnoremap < <gv
vnoremap > >gv

" ESC
imap jk <Esc>
tnoremap <silent> <Esc> <C-\><C-n>

" ウィンドウ移動
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Utility
vnoremap <Leader>e :!sh<CR>
nnoremap <Leader>e V:!sh<CR>
