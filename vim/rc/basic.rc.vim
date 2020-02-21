"================================================================================
" basic settings
"================================================================================
" appearance
set number
set relativenumber
set nowrap
set breakindent
set list
set listchars=tab:»-,trail:-,nbsp:+
set updatetime=100
language C

" コメント行から改行したときに自動コメントアウトしない
autocmd FileType * setlocal formatoptions-=ro

" colors
if exists('&termguicolors')
    set termguicolors
endif
colorscheme iceberg
let g:lightline = {
    \ 'colorscheme': 'iceberg',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['gitbranch', 'filepath', 'readonly', 'modified']],
    \   'right': [['lineinfo'],['filetype'],['fileformat', 'fileencoding']]
    \ },
    \ 'inactive': {
    \   'left': [['filepath']],
    \   'right': [['lineinfo'], ['percent']]
    \ },
    \ 'component_function': {
    \   'mode': 'LightlineMode',
    \   'gitbranch': 'LightlineFugitive',
    \   'filepath': 'LightlineFilepath',
    \   'readonly': 'LightlineReadonly',
    \   'filetype': 'LightlineFiletype',
    \   'fileformat': 'LightlineFileformat',
    \   'fileencoding': 'LightlineFileencoding',
    \ }
    \ }

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineFugitive()
  try
    if &ft !~? 'nerdtree\|tagbar'
      return fugitive#Head()
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFilepath()
  return &ft !~? 'nerdtree\|tagbar' ? expand("%:t") : ''
endfunction

function! LightlineReadonly()
  return &ft !~? 'nerdtree\|tagbar' && &ro ? 'RO' : ''
endfunction

function! LightlineFileformat()
  if winwidth(0) < 81
    return ''
  endif
  if &ff == 'unix'
      return 'LF'
  elseif &ff == 'dos'
      return 'CRLF'
  else
      return 'CR'
  endif
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 80 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightlineFiletype()
  if &ft =~? 'nerdtree\|tagbar'
    return &ft
  endif
  return winwidth(0) > 80 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac

" backup
set noswapfile

" search
set ignorecase
set smartcase
set hlsearch
set wrapscan
set incsearch

" tab
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd Filetype vim,html,css,javascript,yaml,toml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" clipboard
set clipboard+=unnamedplus

" mouse
set mouse=a

" buffer
set hidden

" terminal
set sh=bash
autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
autocmd TermOpen * setlocal norelativenumber nonumber

" persist undo
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
  augroup SaveUndoFile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif

" quickfix
augroup GrepCmd
    autocmd!
    autocmd QuickFixCmdPost vim,grep,make if len(getqflist()) != 0 | cwindow | endif
augroup END

" grep -> ripgrep
if executable('rg')
    let &grepprg = 'rg --vimgrep'
    set grepformat=%f:%l:%c:%m
endif

" abbreviation
:iabbrev bbash #!/bin/bash
:cabbrev sg silent grep!
:cabbrev be bufdo e
:cabbrev recache call dein#recache_runtimepath()
:cabbrev cocui call coc#util#install()
:cabbrev ar AsyncRun
:cabbrev as AsyncStop
