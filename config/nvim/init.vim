"    _      _ __        _
"   (_)__  (_) /_ _  __(_)_ _
"  / / _ \/ / __/| |/ / /  ' \
" /_/_//_/_/\__(_)___/_/_/_/_/
"                   always WIP

set encoding=utf-8
scriptencoding utf-8

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

augroup MyAutoCmd
  autocmd!
augroup END

" encoding
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac

" indentation
set smartindent
set breakindent
set expandtab
set tabstop=2
set shiftwidth=2

" search
" inccommand has bug (2020/10/05)
" set inccommand=nosplit
set ignorecase
set smartcase

" display unprintable characters
set list
set listchars=tab:▸\ ,trail:-,nbsp:+

set noswapfile
set number
set hidden
language en_US

" open command-line window from command-line mode
execute 'set cedit=\<C-c>'

" autoread more frequently
autocmd MyAutoCmd FocusGained,BufEnter * checktime

" undo
set undolevels=1000
set undodir=~/.vim/undo
set undofile

" use block cursor in insert mode
set guicursor=

" prevent accidentally pressing these keys
nnoremap Q <Nop>
nnoremap <F1> <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" move cursor
inoremap <C-b> <C-g>U<Left>
inoremap <C-f> <C-g>U<Right>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" colorscheme
set termguicolors
colorscheme shirotelin

" clipboard
" thanks to monaqa
set clipboard=
autocmd MyAutoCmd TextYankPost * call <SID>copy_unnamed_to_plus(v:event.operator)
function! s:copy_unnamed_to_plus(opr)
  " yank操作のときのみ+レジスタに内容を移す
  if a:opr ==# 'y'
    let @+ = @"
  endif
endfunction

" quickfix and grep
function! ToggleQuickfix()
  let l:nr = winnr('$')
  cwindow 8
  let l:nr2 = winnr('$')
  if l:nr == l:nr2
    cclose
  endif
endfunction
nnoremap <script><silent> <Space>q :call ToggleQuickfix()<CR>
nnoremap <silent> ]q :<C-u>cn<CR>
nnoremap <silent> [q :<C-u>cp<CR>

autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow

nnoremap <Space>f :<C-u>silent grep!<Space>
vnoremap <Space>f "zy:<C-u>silent grep! '<C-r>z'<CR>

if executable('rg')
  let &grepprg = 'rg --vimgrep'
  let &grepformat = '%f:%l:%c:%m'
elseif executable('git') && !empty(system('git rev-parse --git-dir 2>/dev/null'))
  let &grepprg = 'git grep -I --no-color --line-number --column'
  let &grepformat = '%f:%l:%c:%m'
endif

nnoremap Y y$
nmap <silent> <C-l> :<C-u>nohlsearch<CR>:redraw<CR>

" 選択範囲に.で繰り返しコマンド実行する
vnoremap . :normal .<CR>

" awk
function! AwkPrint(line1, line2, ...)
  let args = map(copy(a:000), { _, v -> '$' .. v })
  execute printf("%d,%d!awk '{print %s}'", a:line1, a:line2, join(args, ','))
endfunction
command! -range -nargs=+ Awk :call AwkPrint(<line1>, <line2>, <f-args>)

" abbreviations
cabbrev sg silent grep!
cabbrev windi windo diffthis

" plugins
function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Colorscheme
  call minpac#add('yasukotelin/shirotelin', {'type': 'opt'})

  " Text edit
  call minpac#add('markonm/traces.vim')
  call minpac#add('tpope/vim-commentary')

  " File explore
  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('tatsuya4559/filer.vim')

  " Language support
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
  call minpac#add('SirVer/ultisnips')
  call minpac#add('mattn/emmet-vim', {'type': 'opt'})

  " Git
  call minpac#add('ruanyl/vim-gh-line', {'type': 'opt'})
endfunction

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

" ultisnips
let g:UltiSnipsSnippetDirectories=['~/.vim/ultisnips']

" CtrlP
let g:ctrlp_user_command = 'rg --color never --files --hidden --follow --glob "!.git/*"'
let g:ctrlp_reuse_window = 'filer'
let g:ctrlp_switch_buffer = 0
nnoremap <silent> <Space>b :<C-u>CtrlPBuffer<CR>

" Coc
let g:coc_node_path = has('mac') ? '/usr/local/bin/node' : '/usr/bin/node'
let g:coc_global_extensions = [
      \   'coc-java',
      \   'coc-svelte',
      \   'coc-tsserver',
      \ ]

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <F2> <Plug>(coc-rename)

nnoremap <silent> K :<C-u>call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype =~? '\v(vim|help)'
    execute 'h' expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> <Space>a :<C-u>CocAction<CR>

nnoremap <Leader>f :<C-u>call FormatDocument()<CR>
function! FormatDocument()
  call CocAction('format')
endfunction
