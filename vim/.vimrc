set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac
filetype plugin indent on
syntax enable
language C
set smartindent breakindent
set expandtab tabstop=2 shiftwidth=2
set hlsearch incsearch ignorecase smartcase wrapscan
set shortmess-=S
set backspace=2
set wildmenu
set list listchars=tab:▸\ ,trail:·
set laststatus=2
"set number
"set relativenumber
set ruler
set noswapfile
set nowrap
set hidden
set ttimeoutlen=10
set undolevels=1000 undodir=~/.vim/undo undofile
set termguicolors
set updatetime=300
set nrformats&
set nrformats+=unsigned
augroup MyAutoCmd
  autocmd!
augroup END
set autoread
autocmd MyAutoCmd WinEnter * checktime
packadd! matchit

" plugins
function! PackInit() abort
  packadd! minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " colorscheme
  call minpac#add('tatsuya4559/shirotelin', {'type': 'opt'})
  call minpac#add('cormacrelf/vim-colors-github', {'type': 'opt'})

  " filer & fuzzy finder
  call minpac#add('tatsuya4559/filer.vim')
  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('mattn/ctrlp-matchfuzzy')
  call minpac#add('mattn/ctrlp-lsp')
  call minpac#add('mattn/ctrlp-launcher')

  " git
  call minpac#add('lambdalisue/gina.vim')
  call minpac#add('APZelos/blamer.nvim')

  " lsp
  call minpac#add('prabirshrestha/vim-lsp')
  call minpac#add('prabirshrestha/asyncomplete.vim')
  call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
  call minpac#add('mattn/vim-lsp-settings')

  " others
  call minpac#add('tatsuya4559/qrep.vim')
  call minpac#add('markonm/traces.vim')
  call minpac#add('cohama/lexima.vim')
  call minpac#add('machakann/vim-sandwich')
  call minpac#add('haya14busa/vim-asterisk')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('hrsh7th/vim-vsnip')
  call minpac#add('thinca/vim-quickrun')
  call minpac#add('AndrewRadev/linediff.vim')

  " language specific
  call minpac#add('mattn/emmet-vim')
  call minpac#add('mattn/vim-goimports')
  call minpac#add('hashivim/vim-terraform')
  call minpac#add('tatsuya4559/tfplan.vim')
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
nnoremap <leader>v :e $MYVIMRC<cr>
nnoremap yt :<c-u>tabedit %<cr>
nnoremap <leader>s :!tmux popup -w90\% -h90\% -d '\#{pane_current_path}' -E<cr>
nnoremap <space>t :!tig status<cr>

" submode(https://zenn.dev/mattn/articles/83c2d4c7645faa)
nmap zh zh<SID>z
nmap zl zl<SID>z
nnoremap <script> <SID>zh zh<SID>z
nnoremap <script> <SID>zl zl<SID>z
nmap <SID>z <Nop>

nnoremap H 20zh
nnoremap L 20zl

command! SepLineFeed :s/\\n/\r/g
command! -range AlignTable :<line1>,<line2>!pandoc -t gfm

" colorscheme
colorscheme shirotelin_nobold
let g:is_bash = v:true

" abbreviations
cabbrev w!! w !sudo tee > /dev/null %
cabbrev gina Gina
iabbrev improt import
iabbrev flase false
iabbrev Flase False
iabbrev apn1 ap-northeast-1
iabbrev apn2 ap-northeast-2
iabbrev apn3 ap-northeast-3
iabbrev use1 us-east-1
iabbrev use2 us-east-2

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
  let nr = winnr('$')
  cwindow
  if nr == winnr('$')
    cclose
  endif
endfunction
nnoremap <silent><script> <space>q :<c-u>call <SID>toggle_quickfix()<cr>
nnoremap <silent> ]q :<c-u>cn<cr>
nnoremap <silent> [q :<c-u>cp<cr>
autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow
packadd! cfilter

" qrep
let &grepprg = 'rg --vimgrep --hidden --glob "!.git"'
set grepformat=%f:%l:%c:%m
nnoremap <space>g :<c-u>Qrep<space>

" ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files', 'fd --hidden --type f --color never "" %s']
let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
let g:ctrlp_reuse_window = 'filer'
let g:ctrlp_switch_buffer = ''
nnoremap <space>c <cmd>CtrlPCurFile<cr>
nnoremap <space>b <cmd>CtrlPBuffer<cr>
nnoremap <space>l <cmd>CtrlPLine<cr>
nnoremap <space>p <cmd>CtrlPLauncher<cr>
nnoremap <c-q> <cmd>CtrlPQuickfix<cr>

" lsp
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_settings = {'efm-langserver': {'disabled': v:false}}

function! s:on_hover() abort
  if &filetype ==# 'vim'
    exe 'help' expand('<cword>')
  else
    LspHover
  endif
endfunction

function! s:toggle_diagnostics() abort
  let nr = winnr('$')
  LspDocumentDiagnostics
  if nr == winnr('$')
    lclose
  endif
endfunction

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal tagfunc=lsp#tagfunc
  nmap <buffer><silent> gd <plug>(lsp-definition)
  nmap <buffer><silent> gr <plug>(lsp-references)
  nmap <buffer><silent> gi <plug>(lsp-implementation)
  nmap <buffer><silent> gy <plug>(lsp-type-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  nmap <buffer><silent> [d <plug>(lsp-previous-diagnostic)
  nmap <buffer><silent> ]d <plug>(lsp-next-diagnostic)
  nnoremap <buffer> K <scriptcmd>call <SID>on_hover()<cr>
  nmap <buffer> ga <plug>(lsp-code-action)
  nmap <buffer> <space>s <plug>(lsp-workspace-symbol-search)
  nmap <buffer> <space>d <scriptcmd>call <SID>toggle_diagnostics()<cr>
  nnoremap <buffer> go <cmd>CtrlPLspDocumentSymbol<cr>
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

" blamer
nnoremap <leader>b <cmd>BlamerToggle<cr>

" vsnip
let g:vsnip_snippet_dir = '~/.vim/vsnip/out'
imap <expr> <tab> vsnip#expandable() ? '<plug>(vsnip-expand)' : '<tab>'
imap <expr> <c-j> vsnip#jumpable(1) ? '<plug>(vsnip-jump-next)' : '<c-j>'
imap <expr> <c-k> vsnip#jumpable(-1) ? '<plug>(vsnip-jump-prev)' : '<c-k>'

function! s:edit_vsnip_src(filetype) abort
  let filetype = empty(a:filetype) ? &filetype : a:filetype
  let snip_src = printf('~/.vim/vsnip/src/%s.yaml', filetype)
  exe printf('autocmd MyAutoCmd BufWritePost %s call system("~/.vim/vsnip/transpile_vsnip.sh")', snip_src)
  exe 'edit' snip_src
endfunction
command! -nargs=? VsnipEdit :call s:edit_vsnip_src(<q-args>)

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

" filetype
autocmd MyAutoCmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab listchars=tab:\ \ ,trail:·
autocmd MyAutoCmd FileType yaml setlocal lisp
autocmd MyAutoCmd FileType gitcommit setlocal spell textwidth=0
autocmd MyAutoCmd BufReadPost .ctrlp-launcher setlocal tabstop=8 shiftwidth=8 noexpandtab

" vim-test
let g:test#strategy = 'vimterminal'
let g:test#python#runner = 'pytest'
let g:test#python#pytest#executable = 'pytest -v --disable-warnings --no-migrations --reuse-db'
nnoremap <leader>tf <cmd>TestFile<cr>
nnoremap <leader>tn <cmd>TestNearest<cr>
nnoremap <leader>tt <cmd>TestLast<cr>

" angular
function! s:ng_goto_companion_file() abort
  let extension = expand('%:e') ==# 'ts' ? '.html' : '.ts'
  let filename = expand('%:p:r') .. extension
  if filereadable(filename)
    exe 'edit' filename
  else
    echom 'Cannot open ' .. filename
  endif
endfunction
nnoremap <leader>t :<c-u>call <SID>ng_goto_companion_file()<cr>

" lexima
command! ToggleLexima let b:lexima_disabled = !get(b:, 'lexima_disabled', 0)
call lexima#add_rule({'char': "'", 'at': '\%#\w', 'input': "'"})
call lexima#add_rule({'char': '"', 'at': '\%#\w', 'input': '"'})
call lexima#add_rule({'char': '(', 'at': '\%#\w', 'input': '('})
call lexima#add_rule({'char': '{', 'at': '\%#\w', 'input': '{'})
call lexima#add_rule({'char': '[', 'at': '\%#\w', 'input': '['})
