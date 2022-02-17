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
function! PackInit() abort
  packadd! minpac
  call minpac#init({'package_name': 'plug'})
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('yasukotelin/shirotelin', {'type': 'opt'})
  call minpac#add('tatsuya4559/filer.vim')
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('mhinz/vim-grepper')
  call minpac#add('markonm/traces.vim')
  call minpac#add('machakann/vim-sandwich')
  call minpac#add('haya14busa/vim-asterisk')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('SirVer/ultisnips')
  call minpac#add('lambdalisue/gina.vim')
  call minpac#add('APZelos/blamer.nvim')
  call minpac#add('prabirshrestha/vim-lsp')
  call minpac#add('mattn/vim-lsp-settings')
  call minpac#add('thinca/vim-quickrun')
  call minpac#add('mattn/emmet-vim')
  call minpac#add('mattn/vim-goimports')
  call minpac#add('vim-test/vim-test')
endfunction
command! PackUpdate call PackInit() | call minpac#update()
command! PackClean call PackInit() | call minpac#clean()

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
packadd! cfilter

" grepper
nnoremap <space>g <cmd>Grepper<cr>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
let g:grepper = {
      \ 'highlight': v:true,
      \ 'side_cmd': 'tabnew'
      \ }

" ctrlsf
let g:ctrlsf_auto_focus = {'at': 'start'}
let g:ctrlsf_position = 'bottom'
nnoremap <space>f :<c-u>CtrlSF<space>
nnoremap <leader>f <cmd>CtrlSFToggle<cr>

" filetype
autocmd MyAutoCmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd MyAutoCmd FileType python setlocal tabstop=4 shiftwidth=4

" fzf
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']
nnoremap <c-p> :<c-u>Files<cr>
nnoremap <space>b :<c-u>Buffers<cr>
nnoremap <space>l <cmd>BLines<cr>
nnoremap <space>r :<c-u>Rg <c-r><c-w><cr>
vnoremap <space>r "zy:Rg <c-r>z<cr>

" lsp
let g:lsp_document_highlight_enabled = 0
let g:lsp_diagnostics_float_cursor = 1
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal tagfunc=lsp#tagfunc
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

" util
function! s:echoerr(msg, ...) abort
  redraw
  echohl Error
  echomsg call(function('printf', [a:msg]), a:000)
  echohl None
endfunction

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

" separate html attrs
command! Sep :s/\S\zs<space>\+/\r/g | :nohlsearch

" google
function! s:google(...) abort
  if empty(a:000)
    return
  endif
  let l:url = shellescape('https://www.google.com/search?q='
      \ .. join(a:000, '+'))
  " I don't have windows
  let l:openprg = has('mac') ? 'open' : 'xdg-open'
  call system(printf('%s %s', l:openprg, l:url))
endfunction
command! -nargs=* Google call s:google(<f-args>)
nnoremap <silent> <leader>gg :Google <c-r><c-w><cr><cr>
vnoremap <silent> <leader>gg "zy:Google <c-r>z<cr>

" copy path
command! CopyPath :let @+ = expand('%')
command! CopyFullPath :let @+ = expand('%:p')

" vim-test
let g:test#strategy = 'vimterminal'
let g:test#python#runner = 'pytest'
let g:test#python#pytest#executable = 'pytest -v'
nnoremap <leader>tf <cmd>TestFile<cr>
nnoremap <leader>tn <cmd>TestNearest<cr>
nnoremap <leader>tt <cmd>TestLast<cr>
