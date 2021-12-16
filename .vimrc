set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac
filetype plugin indent on
syntax enable
language C
set smartindent
set expandtab tabstop=2 shiftwidth=2
set hlsearch incsearch ignorecase smartcase wrapscan
set shortmess-=S
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
set cmdheight=2
set signcolumn=number
set termguicolors
set updatetime=300
set nrformats&
set nrformats+=unsigned
augroup MyAutoCmd
  autocmd!
augroup END
set autoread
autocmd MyAutoCmd FocusGained,BufEnter * checktime

" plugins
call plug#begin('~/.vim/plugged')
Plug 'yasukotelin/shirotelin'
Plug 'overcache/NeoSolarized'
Plug 'tatsuya4559/filer.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'markonm/traces.vim'
Plug 'machakann/vim-sandwich'
Plug 'haya14busa/vim-asterisk'
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips'
Plug 'lambdalisue/gina.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'editorconfig/editorconfig-vim'
Plug 'thinca/vim-quickrun'
Plug 'mattn/emmet-vim'
Plug 'mattn/vim-goimports', {'for': 'go'}
Plug 'vim-test/vim-test'
call plug#end()

" keymaps
nnoremap <f1> <nop>
nnoremap Q <nop>
nnoremap ZZ <nop>
nnoremap ZQ <nop>
nnoremap <silent> <c-l> :<c-u>nohlsearch<cr><c-l>
vnoremap . :normal .<cr>
nnoremap Y y$
nnoremap <c-w>- :<c-u>sp %:h<cr>
nnoremap <c-w>g <c-w>sgg
nnoremap vv vg_
tnoremap <esc><esc> <c-\><c-n>
nnoremap <s-left> zh
nnoremap <s-right> zl
nnoremap <leader>v :e $MYVIMRC<cr>
nnoremap yt :<c-u>tabedit %<cr>

" colorscheme
colorscheme shirotelin

" abbreviations
cabbrev w!! w !sudo tee > /dev/null %

" clipboard (thanks to monaqa
set clipboard=
autocmd MyAutoCmd TextYankPost * call s:copy_unnamed_to_plus(v:event.operator)
function! s:copy_unnamed_to_plus(opr)
  if a:opr ==# 'y'
    let @+ = @"
  endif
endfunction

" auto mkdir
function! s:auto_mkdir(dir) abort
  if !isdirectory(a:dir) &&
        \ input(printf('"%s" does not exist. Should it be created? (y/N)', a:dir)) =~? '^y\%[es]$'
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))

" quickfix
function! s:toggle_quickfix()
  let l:nr = winnr('$')
  cwindow
  let l:nr2 = winnr('$')
  if l:nr == l:nr2
    cclose
  endif
endfunction
nnoremap <silent><script> <space>q :<c-u>call <SID>toggle_quickfix()<cr>
nnoremap <silent> ]q :<c-u>cn<cr>
nnoremap <silent> [q :<c-u>cp<cr>
autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow

" filetype
autocmd MyAutoCmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd MyAutoCmd FileType python setlocal tabstop=4 shiftwidth=4

" fzf
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']
nnoremap <c-p> :<c-u>Files<cr>
nnoremap <space>b :<c-u>Buffers<cr>
nnoremap <space>r :<c-u>Rg <c-r><c-w><cr>
vnoremap <space>r "zy:Rg <c-r>z<cr>

" lsp
let g:lsp_document_highlight_enabled = 0
let g:lsp_diagnostics_float_cursor = 1
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  nmap <buffer><silent> gd <plug>(lsp-definition)
  nmap <buffer><silent> gr <plug>(lsp-references)
  nmap <buffer><silent> gi <plug>(lsp-implementation)
  nmap <buffer><silent> gy <plug>(lsp-type-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  nmap <buffer><silent> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer><silent> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  nmap <buffer> <leader>a <plug>(lsp-code-action)
  nmap <buffer> <space>o <plug>(lsp-document-symbol-search)
  nmap <buffer> <space>s <plug>(lsp-workspace-symbol-search)

  nmap <buffer><silent> <c-w><c-]> <c-w>s<plug>(lsp-definition)
endfunction
autocmd MyAutoCmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()

" quickrun
nmap <leader>r <plug>(quickrun)

" asterisk
map * <plug>(asterisk-z*)
map # <plug>(asterisk-z#)

" gina
nnoremap <silent><leader>gh :<c-u>Gina browse --exact : <cr>
vnoremap <silent><leader>gh :Gina browse --exact : <cr>
nnoremap <silent><leader>gy :<c-u>Gina browse --exact --yank :<cr>:let @+ = @"<cr>
vnoremap <silent><leader>gy :Gina browse --exact --yank : <cr>:let @+ = @"<cr>

" ctrlsf
let g:ctrlsf_populate_qflist = 1
let g:ctrlsf_auto_focus = {'at': 'start'}
let g:ctrlsf_case_sensitive = 'yes'
let g:ctrlsf_position = 'bottom'
nnoremap <space>f :<c-u>CtrlSF<space>
vnoremap <space>f "zy:CtrlSF <c-r>z<cr>
nnoremap <leader>f <cmd>CtrlSFToggle<cr>

" angular
function! s:ng_goto_companion_file() abort
  let extension = expand('%:e') ==# 'ts' ? '.html' : '.ts'
  let filename = expand('%:p:r') .. extension
  if filereadable(filename)
    exe 'edit' filename
  else
    call s:echoerr('Cannot open %s', filename)
  endif
endfunction
nnoremap <leader>t :<c-u>call <SID>ng_goto_companion_file()<cr>

" util
function! s:echoerr(msg, ...) abort
  redraw
  echohl Error
  echomsg call(function('printf', [a:msg]), a:000)
  echohl None
endfunction


" startup time
let g:startuptime = reltime()
autocmd MyAutoCmd VimEnter *
      \ : let g:startuptime = reltime(g:startuptime)
      \ | redraw
      \ | echomsg printf('startuptime: %s seconds', reltimestr(g:startuptime))

function! s:open_file_with_position(file_identifiler) abort
  let splitted = split(a:file_identifiler, ':', 1)
  let filename = splitted[0]
  let lnum = len(splitted) >= 2 ? splitted[1] : 1
  let col = len(splitted) >= 3 ? splitted[2] : 1

  exe 'edit' filename
  call cursor(lnum, col)
  normal zz
endfunction
command! -nargs=1 O call s:open_file_with_position('<args>')
nnoremap <leader>o :call <SID>open_file_with_position(getline('.'))<cr>

let g:test#strategy = 'vimterminal'
let g:test#python#runner = 'pytest'
let g:test#python#pytest#executable = 'pytest -v -x --pdb'
