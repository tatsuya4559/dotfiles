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
set shortmess+=c
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
colorscheme atamaplus
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

" grep
nnoremap <space>f :<c-u>silent grep!<space>
set grepprg=git\ grep\ -I\ --color=never
set grepformat=%f:%l:%c:%m

" filetype
autocmd MyAutoCmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd MyAutoCmd FileType python setlocal tabstop=4 shiftwidth=4

" plugins
call plug#begin('~/.config/nvim/plugged')
" visual effect
Plug 'overcache/NeoSolarized'
Plug 'cocopon/shadeline.vim'

" file explorer
Plug 'tatsuya4559/filer.vim'
Plug 'lambdalisue/fern.vim'

" searcher
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'AndrewRadev/writable_search.vim'

" editing
Plug 'markonm/traces.vim'
Plug 'machakann/vim-sandwich'
Plug 'cohama/lexima.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'tpope/vim-commentary'

" language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'mattn/emmet-vim'
Plug 'editorconfig/editorconfig-vim'

" misc
Plug 'lambdalisue/gina.vim'
Plug 'thinca/vim-quickrun'
call plug#end()

" fzf
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']
nnoremap <c-p> :<c-u>Files<cr>
nnoremap <space>b :<c-u>Buffers<cr>

" lsp {{{
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

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}

" quickrun
nmap <space>r <Plug>(quickrun)

" asterisk
map * <Plug>(asterisk-z*)
map # <Plug>(asterisk-z#)

" gina
" GitHubで開く以外の操作はtig or gitでやる
nnoremap <silent><space>gh :<c-u>Gina browse --exact : <cr>
vnoremap <silent><space>gh :Gina browse --exact : <cr>
nnoremap <silent><space>gy :<c-u>Gina browse --exact --yank :<cr>:let @+ = @"<cr>
vnoremap <silent><space>gy :Gina browse --exact --yank : <cr>:let @+ = @"<cr>

" fern
nnoremap <space>e <cmd>Fern . -drawer -toggle -reveal=%<cr>

" angular
function! s:ng_goto_companion_file() abort
  let extension = expand('%:e') ==# 'ts' ? '.html' : '.ts'
  let filename = expand('%:p:r') .. extension
  exe 'edit' filename
endfunction
nnoremap <leader>t :<c-u>call <SID>ng_goto_companion_file()<cr>
