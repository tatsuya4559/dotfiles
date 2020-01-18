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

" colors and lightline
if exists('&termguicolors')
    set termguicolors
    " autocmd ColorScheme * hi Conceal ctermbg=none guibg=none
    autocmd ColorScheme * hi Comment ctermbg=none guibg=none gui=none
    " autocmd ColorScheme * hi shComment ctermbg=none guibg=none gui=none
    " autocmd ColorScheme * hi jsComment ctermbg=none guibg=none gui=none
    " autocmd ColorScheme * hi javaScriptLineComment ctermbg=none guibg=none gui=none
else
    autocmd ColorScheme * hi Normal ctermbg=none guibg=none
    autocmd ColorScheme * hi NonText ctermbg=none guibg=none
    autocmd ColorScheme * hi LineNr ctermbg=none guibg=none
endif

colorscheme gruvbox-material
set background=light
let g:gruvbox_material_background = 'medium'
let g:lightline = {
    \ 'colorscheme': 'gruvbox_material',
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
    if &ft !~? 'coc-explorer\|tagbar' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFilepath()
  return &ft !~? 'coc-explorer\|tagbar' ? expand("%:t") : ''
endfunction

function! LightlineReadonly()
  return &ft !~? 'coc-explorer\|tagbar' && &ro ? 'RO' : ''
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
  if &ft =~? 'coc-explorer\|tagbar'
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
