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
set showcmd
set backspace=2
set wildmenu
set list listchars=tab:▸\ ,trail:·
set laststatus=2
set number
set relativenumber
set ruler
set noswapfile
set nowrap
set hidden
set wildoptions=fuzzy,pum
set ttimeoutlen=10
set diffopt=internal,filler,algorithm:histogram,indent-heuristic,closeoff
set undolevels=1000 undodir=~/.vim/undo undofile
if !isdirectory(expand('~/.vim/undo'))
  call mkdir(expand('~/.vim/undo'), "p")
endif
set nrformats& nrformats+=unsigned
augroup MyAutoCmd
  autocmd!
augroup END
set autoread
autocmd MyAutoCmd WinEnter * checktime

" Keymaps
nnoremap <f1> <nop>
nnoremap Q <nop>
nnoremap ZZ <nop>
nnoremap ZQ <nop>
nmap s <nop>
xmap s <nop>
vnoremap . :normal .<cr>
nnoremap Y y$
nnoremap <c-w>- :<c-u>sp %:h<cr>
nnoremap <c-w>g <c-w>sgg
nnoremap vv vg_
tnoremap <esc><esc> <c-\><c-n>
nnoremap <leader>w <cmd>setlocal wrap!<cr>
nnoremap <leader>v :exe 'edit' resolve($MYVIMRC)<cr>
nnoremap H 20zh
nnoremap L 20zl
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <silent> <c-l> :<c-u>nohlsearch<cr><c-l>
cnoremap <c-p> <up>
inoremap <c-g><c-u> <esc>gUiwgi

" Macro
" @e turns `fn()` into `if err := fn(); err != nil { return err }`
let @e = 'Iif err := A; err != nil {}Oreturn err'

" Colorscheme
colorscheme habamax
let g:is_bash = v:true

" Abbreviations
cabbrev w!! w !sudo tee > /dev/null %
cabbrev gina Gina
cabbrev te term ++close
iabbrev improt import
iabbrev flase false
iabbrev Flase False
iabbrev apn1x ap-northeast-1
iabbrev apn3x ap-northeast-3
iabbrev use1x us-east-1

" Utilities

let s:is_wsl = isdirectory('/mnt/c')

" clipboard (thanks to monaqa
set clipboard=
autocmd MyAutoCmd TextYankPost * call s:copy_unnamed_to_plus(v:event.operator)
function! s:copy_unnamed_to_plus(opr)
  if a:opr ==# 'y'
    if s:is_wsl
      call system('clip.exe', @")
    else
      let @+ = @"
    endif
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

" copy path
command! CopyPath :let @+ = expand('%')
command! CopyFullPath :let @+ = expand('%:p')

" align column, table
command! -range=% Align :<line1>,<line2>!column -t
command! -range=% AlignTable :<line1>,<line2>!pandoc -t commonmark_x
command! -range=% TableFromCsv :<line1>,<line2>!pandoc -f csv -t commonmark_x

" open terminal in buffer's dir
function! s:open_term_bufdir() abort
  let sh = getenv('SHELL')
  call term_start(sh, {'cwd': expand('%:h'), 'term_finish': 'close'})
endfunction

nnoremap <leader>t <scriptcmd>call <SID>open_term_bufdir()<cr>

" Quickfix
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

" Filetype
autocmd MyAutoCmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab listchars=tab:\ \ ,trail:·
autocmd MyAutoCmd FileType yaml setlocal lisp
autocmd MyAutoCmd FileType gitcommit setlocal spell textwidth=0
autocmd MyAutoCmd BufReadPost .ctrlp-launcher setlocal tabstop=8 shiftwidth=8 noexpandtab
autocmd MyAutoCmd BufWritePre *.go call execute('LspDocumentFormatSync') | call execute('LspCodeActionSync source.organizeImports')

" Plugins
packadd! matchit
packadd! cfilter
function! PackInit() abort
  packadd! minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " filer & fuzzy finder
  call minpac#add('tatsuya4559/filer.vim')
  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('mattn/ctrlp-matchfuzzy')
  call minpac#add('mattn/ctrlp-lsp')
  call minpac#add('mattn/ctrlp-launcher')

  " git
  call minpac#add('lambdalisue/gina.vim')
  call minpac#add('APZelos/blamer.nvim')
  call minpac#add('mhinz/vim-signify')

  " lsp
  call minpac#add('prabirshrestha/vim-lsp')
  call minpac#add('mattn/vim-lsp-settings')

  " editing
  call minpac#add('machakann/vim-sandwich')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('hrsh7th/vim-vsnip')
  call minpac#add('tatsuya4559/vim-vsnip-toml')
  call minpac#add('github/copilot.vim')

  " enhance default features
  call minpac#add('tatsuya4559/qrep.vim')
  call minpac#add('markonm/traces.vim')
  call minpac#add('haya14busa/vim-asterisk')
  call minpac#add('itchyny/vim-qfedit')

  " others
  call minpac#add('thinca/vim-quickrun')
  call minpac#add('AndrewRadev/linediff.vim')
  call minpac#add('vim-jp/vital.vim', {'type': 'opt'})

  " language specific
  call minpac#add('mattn/emmet-vim')
  call minpac#add('hashivim/vim-terraform')
  call minpac#add('jeetsukumaran/vim-python-indent-black')
endfunction
command! PackUpdate call PackInit() | call minpac#update()
command! PackClean call PackInit() | call minpac#clean()

" Plugin settings

" qrep and grep
let &grepprg = 'git grep --line --column --no-color'
set grepformat=%f:%l:%c:%m
nnoremap <space>v :<c-u>vimgrep /<c-r><c-w>/j %<cr>
nnoremap <space>g :<c-u>Qrep<space>

" emmet
let g:user_emmet_mode = 'i'

" ctrlp
let g:ctrlp_user_command = 'fd --hidden --type f --color never "" %s'
let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
let g:ctrlp_reuse_window = 'filer'
let g:ctrlp_switch_buffer = ''
let g:ctrlp_clear_cache_on_exit = 0
nnoremap <space>w <cmd>CtrlPCurWD<cr>
nnoremap <space>f <cmd>CtrlPCurFile<cr>
nnoremap <space>b <cmd>CtrlPBuffer<cr>
nnoremap <space>l <cmd>CtrlPLine %<cr>
nnoremap <space>p <cmd>CtrlPLauncher<cr>

" lsp
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_settings = {'efm-langserver': {'disabled': v:false}}
let g:lsp_document_highlight_enabled = v:false

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

function! s:is_document_hover_visible() abort
  return lsp#document_hover_preview_winid() != v:null
endfunction

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal tagfunc=lsp#tagfunc
  " popup windowが残らないようにjkしてからジャンプする
  nmap <buffer><silent> gd jk<plug>(lsp-definition)
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
  nnoremap <buffer> <leader>f <cmd>LspDocumentFormat<cr>
  nmap <buffer><expr> <c-y> <SID>is_document_hover_visible() ? lsp#scroll(-1) : '<c-y>'
  nmap <buffer><expr> <c-e> <SID>is_document_hover_visible() ? lsp#scroll(+1) : '<c-e>'
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
command! -nargs=1 OpenInBranch exe printf('Gina show %s:%s', <f-args>, expand('%'))

" blamer
nnoremap <leader>b <cmd>BlamerToggle<cr>

" vsnip
let g:vsnip_snippet_src_dir = '~/.vim/vsnip/src'
let g:vsnip_snippet_dir = '~/.vim/vsnip/out'
imap <expr> <c-g><c-g> vsnip#expandable() ? '<plug>(vsnip-expand)' : '<c-g><c-g>'
imap <expr> <c-j> vsnip#jumpable(1) ? '<plug>(vsnip-jump-next)' : '<c-j>'
imap <expr> <c-k> vsnip#jumpable(-1) ? '<plug>(vsnip-jump-prev)' : '<c-k>'
nnoremap <leader>s <cmd>VsnipEditTOML<cr>

" terraform
let g:terraform_fmt_on_save = v:true

let s:job = {}
function! s:async_run_tfdocs(filename) abort
  let cmd = printf('pre-commit run terraform_docs --files %s', a:filename)
  " jobがkillされないように参照をscript local scopeに残しておく
  let s:job[cmd] = job_start(cmd, {"in_io": "null", "out_io": "null", "err_io": "null"})
endfunction
autocmd MyAutoCmd BufWritePost *.tf call s:async_run_tfdocs(expand('%'))

" copilot
" let g:copilot_filetypes = {
"       \ '*': v:false,
"       \ }
imap <c-b> <plug>(copilot-previous)
imap <c-f> <plug>(copilot-next)
imap <c-x><c-x> <plug>(copilot-suggest)

" Additional scripts
if has('vim9script')
  runtime! rc/*.vim
endif

" vim: tabstop=2 shiftwidth=2
