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
autocmd ColorScheme * hi Normal ctermbg=none
autocmd ColorScheme * hi NonText ctermbg=none
autocmd ColorScheme * hi LineNr ctermbg=none

colorscheme iceberg
let g:lightline = {
    \ 'colorscheme': 'iceberg',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filepath', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'filepath': 'FilePath'
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
    \ }
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
autocmd Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" clipboard
set clipboard+=unnamedplus

" mouse
set mouse=a

" buffer
set hidden

" terminal
set sh=bash
autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
autocmd TermOpen * setlocal nonumber

" persist undo
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
  augroup SaveUndoFile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif

" qf
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

