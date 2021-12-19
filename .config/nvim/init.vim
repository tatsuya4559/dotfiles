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
set undolevels=1000 undodir=~/.config/nvim/undo undofile
set cmdheight=2
set signcolumn=number
set termguicolors
set updatetime=300
colorscheme darkblue
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
if !exists('g:vscode')
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
endif

" filetype
autocmd MyAutoCmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd MyAutoCmd FileType python setlocal tabstop=4 shiftwidth=4

" plugins
call plug#begin('~/.config/nvim/plugged')
if !exists('g:vscode')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'dyng/ctrlsf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tatsuya4559/filer.vim'
  Plug 'cohama/lexima.vim'
  Plug 'lambdalisue/gina.vim'
  Plug 'thinca/vim-quickrun'
  Plug 'mattn/emmet-vim'
  Plug 'editorconfig/editorconfig-vim'
endif
Plug 'markonm/traces.vim'
Plug 'machakann/vim-sandwich'
Plug 'haya14busa/vim-asterisk'
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips'
call plug#end()

" lsp {{{
if exists('g:vscode')
  nnoremap <silent> gr <cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<cr>
  nnoremap <silent> <space>o <cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>
else
  inoremap <silent><expr> <c-x><c-o> coc#refresh()
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  autocmd CursorHold * silent call CocActionAsync('highlight')

  nmap <f2> <Plug>(coc-rename)
  nmap <space>a  <Plug>(coc-codeaction)
  nmap <leader>qf  <Plug>(coc-fix-current)

  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
endif
" }}}

" quickrun
if !exists('g:vscode')
nmap <leader>r <plug>(quickrun)
endif

" asterisk
map * <plug>(asterisk-z*)
map # <plug>(asterisk-z#)

" gina
if exists('g:vscode')
  nnoremap <silent><leader>gh <cmd>call VSCodeNotify('extension.openInGitHub')<cr>
else
nnoremap <silent><leader>gh :<c-u>Gina browse --exact : <cr>
vnoremap <silent><leader>gh :Gina browse --exact : <cr>
nnoremap <silent><leader>gy :<c-u>Gina browse --exact --yank :<cr>:let @+ = @"<cr>
vnoremap <silent><leader>gy :Gina browse --exact --yank : <cr>:let @+ = @"<cr>
endif

" ctrlsf
if !exists('g:vscode')
  let g:ctrlsf_populate_qflist = 1
  let g:ctrlsf_auto_focus = {'at': 'start'}
  let g:ctrlsf_case_sensitive = 'yes'
  let g:ctrlsf_position = 'bottom'
  nnoremap <space>f :<c-u>CtrlSF<space>
  nnoremap <leader>f <cmd>CtrlSFToggle<cr>
endif

" telescope
if exists('g:vscode')
  nnoremap <silent> <space>b <cmd>call VSCodeNotify('workbench.action.showAllEditors')<cr>
else
  nnoremap <c-p> <cmd>Telescope find_files theme=dropdown<cr>
  nnoremap <space>g <cmd>Telescope live_grep theme=dropdown<cr>
  nnoremap <space>b <cmd>Telescope buffers theme=dropdown<cr>
endif

" angular
if exists('g:vscode')
  nnoremap <leader>t <cmd>call VSCodeNotify('angular.goToTemplateForComponent')<cr>
  nnoremap <leader>c <cmd>call VSCodeNotify('angular.goToComponentWithTemplateFile')<cr>
else
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
endif

" util
function! s:echoerr(msg, ...) abort
  redraw
  echohl Error
  echomsg call(function('printf', [a:msg]), a:000)
  echohl None
endfunction
