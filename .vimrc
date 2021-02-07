set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac
filetype plugin indent on
syntax enable
language en_US
set smartindent breakindent
set expandtab tabstop=2 shiftwidth=2
set hlsearch incsearch ignorecase smartcase wrapscan
set shortmess-=S showcmd
set backspace=2
set wildmenu
set list listchars=tab:▸\ ,trail:-
set laststatus=2
set ruler number
set noswapfile
set nowrap
set hidden
set ttimeoutlen=10
set undolevels=1000 undodir=~/.vim/undo undofile
execute 'set cedit=\<c-c>'
set termguicolors
colorscheme shirotelin
augroup MyAutoCmd
  autocmd!
augroup END
set autoread
autocmd MyAutoCmd FocusGained,BufEnter * checktime

" keymaps
nnoremap <f1> <nop>
nnoremap Q <nop>
nnoremap ZZ <nop>
nnoremap ZQ <nop>
noremap! <c-b> <left>
noremap! <c-f> <right>
cnoremap <c-a> <home>
nnoremap <silent> <c-l> :<c-u>nohlsearch<cr><c-l>
vnoremap . :normal .<cr>
nnoremap Y y$

" clipboard (thanks to monaqa
set clipboard=
autocmd MyAutoCmd TextYankPost * call s:copy_unnamed_to_plus(v:event.operator)
function! s:copy_unnamed_to_plus(opr)
  if a:opr ==# 'y'
    let @+ = @"
  endif
endfunction

" quickfix
function! s:toggle_quickfix()
  let l:nr = winnr('$')
  cwindow
  let l:nr2 = winnr('$')
  if l:nr == l:nr2
    cclose
  endif
endfunction
nnoremap <script><silent> <space>q :call <SID>toggle_quickfix()<cr>
nnoremap <silent> ]q :<c-u>cn<cr>
nnoremap <silent> [q :<c-u>cp<cr>

" grep
function! s:grep(word) abort
  let l:cmd = 'rg --vimgrep --color never --hidden --glob "!.git/*" "%s"'
  cgetexpr system(printf(l:cmd, a:word)) | cw
endfunction
command! -nargs=1 Grep call s:grep(<q-args>)
nnoremap <space>f :<c-u>Grep<space>
nnoremap gr :<c-u>Grep \b<c-r><c-w>\b<cr>

" filetype
" ftplugin and ftdetect are prepared for each environment
autocmd MyAutoCmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd MyAutoCmd FileType python setlocal tabstop=4 shiftwidth=4

" plugins
function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('yasukotelin/shirotelin', {'type': 'opt'})
  call minpac#add('tatsuya4559/newspaper.vim', {'type': 'opt'})
  call minpac#add('tatsuya4559/vim-eldar', {'type': 'opt'})
  "call minpac#add('tatsuya4559/filer.vim')
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('markonm/traces.vim')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('SirVer/ultisnips')
  call minpac#add('ruanyl/vim-gh-line')
  call minpac#add('mattn/emmet-vim', {'type': 'opt'})
  call minpac#add('mattn/vim-goimports')
endfunction
command! PackUpdate call PackInit() | call minpac#update()
command! PackClean call PackInit() | call minpac#clean()

let g:netrw_banner = 0
nnoremap - :<c-u>Explore<cr>
nnoremap <c-w>- :<c-u>Sexplore<cr>
let g:fzf_preview_window = []
let g:fzf_layout = {'window': 'bo 10new'}
nnoremap <c-p> :Files<cr>
nnoremap <space>b :Buffers<cr>
