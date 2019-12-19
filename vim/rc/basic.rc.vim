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

" colors and lightline
if exists('&termguicolors')
    set termguicolors
else
    autocmd ColorScheme * hi Normal ctermbg=none guibg=none
    autocmd ColorScheme * hi NonText ctermbg=none guibg=none
    autocmd ColorScheme * hi LineNr ctermbg=none guibg=none
endif

colorscheme iceberg
let g:lightline = {
    \ 'colorscheme': 'iceberg',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filepath', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'Fugitive',
    \   'readonly': 'Readonly',
    \   'filepath': 'FilePath'
    \ },
    "\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    "\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
    \ 'separator': { 'left': "\ue0b4", 'right': "\ue0b6 " },
    \ 'subseparator': { 'left': "\ue0b5", 'right': "\ue0b7" }
    \ }

function! Fugitive()
  try
    if &ft !~? 'nerdtree\|tagbar' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? "\ue725 "._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! Readonly()
  return &ft !~? 'nerdtree\|tagbar' && &ro ? "\ue0a2" : ''
endfunction

function! FilePath()
    if winwidth(0) > 90
        return expand("%:s")
    else
        return expand("%:t")
    endif
endfunction

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac

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
autocmd Filetype html,css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

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
