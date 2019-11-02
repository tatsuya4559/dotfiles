" remap/shortcut
let mapleader = "\<Space>"

nnoremap H ^
nnoremap L $
nnoremap j gj
nnoremap k gk
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$<Right>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-h> <BS>
inoremap <C-d> <Del>
inoremap <C-k> <C-o>D<Right>
inoremap <C-u> <C-o>d^
inoremap <C-w> <C-o>db

nnoremap vv v$h
vnoremap < <gv
vnoremap > >gv

imap jk <Esc>

nnoremap <Left> <C-w>h
nnoremap <Down> <C-w>j
nnoremap <Up> <C-w>k
nnoremap <Right> <C-w>l

vnoremap <Leader>e :!sh<CR>
nnoremap <Leader>e V:!sh<CR>
