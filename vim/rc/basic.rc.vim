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
    autocmd ColorScheme * hi Conceal ctermbg=none guibg=none
    autocmd ColorScheme * hi Comment ctermbg=none guibg=none gui=none
    autocmd ColorScheme * hi shComment ctermbg=none guibg=none gui=none
    autocmd ColorScheme * hi jsComment ctermbg=none guibg=none gui=none
    autocmd ColorScheme * hi javaScriptLineComment ctermbg=none guibg=none gui=none
else
    autocmd ColorScheme * hi Normal ctermbg=none guibg=none
    autocmd ColorScheme * hi NonText ctermbg=none guibg=none
    autocmd ColorScheme * hi LineNr ctermbg=none guibg=none
endif

" night-owl nightowl
" gruvbox-material gruvbox_material
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
    \   'gitbranch': 'LightlineFugitive',
    \   'filepath': 'LightlineFilepath',
    \   'readonly': 'LightlineReadonly',
    \   'fileformat': 'LightlineFileformat',
    \ }
    \ }
    " for powerline
    " \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    " \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }

function! LightlineFugitive()
  try
    if &ft !~? 'nerdtree\|tagbar' && exists('*fugitive#head')
      " for nerdfont
      " let _ = fugitive#head()
      " return strlen(_) ? "\ue725 "._ : ''
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFilepath()
    return expand("%:s")
endfunction

function! LightlineReadonly()
  " for nerdfont
  " return &ft !~? 'nerdtree\|tagbar' && &ro ? '\ue0a2' : ''
  return &ft !~? 'nerdtree\|tagbar' && &ro ? 'RO' : ''
endfunction

function! LightlineFileformat()
    if &ff == 'unix'
        return 'LF'
    elseif &ff == 'dos'
        return 'CRLF'
    else
        return 'CR'
    endif
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
:cabbrev ntf NERDTreeFind
:cabbrev be bufdo e
