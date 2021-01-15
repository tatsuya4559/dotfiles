" 誤爆するキーを無効化 {{{
nnoremap Q <Nop>
nnoremap <F1> <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" }}}

" prefixにするキーを無効化 {{{
noremap s <Nop>
noremap <Space> <Nop>
" }}}

" カーソル移動 {{{
noremap! <C-b> <Left>
noremap! <C-f> <Right>
inoremap <C-a> <C-o>^
noremap! <C-e> <End>

cnoremap <C-d> <Del>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-a> <Home>
" }}}

" カラースキーム {{{
set termguicolors
colorscheme shirotelin
" }}}

" クリップボードを共有 {{{
" thanks to monaqa
set clipboard=

noremap <Space>p "+p
noremap <Space>P "+P

augroup YankToClipboard
  autocmd!
  autocmd TextYankPost * call <SID>copy_unnamed_to_plus(v:event.operator)
augroup END

function! s:copy_unnamed_to_plus(opr)
  " yank操作のときのみ+レジスタに内容を移す
  if a:opr ==# 'y'
    let @+ = @"
  endif
endfunction
" }}}

" vvで行末まで選択 {{{
nnoremap vv v$h
" }}}

" ウィンドウ操作のprefixをsに割り当てる {{{
nnoremap s <C-w>
" }}}

" 横スクロール {{{
nnoremap <silent> <Right> zl
nnoremap <silent> <Left> zh
" }}}

" QuickFix移動 {{{
nnoremap <silent> ]q :<C-u>cn<CR>
nnoremap <silent> [q :<C-u>cp<CR>
" }}}

" QuickFixをトグル {{{
function! ToggleQuickfix()
  let l:nr = winnr('$')
  cwindow 8
  let l:nr2 = winnr('$')
  if l:nr == l:nr2
    cclose
  endif
endfunction
nnoremap <script><silent> <Space>q :call ToggleQuickfix()<CR>
" }}}

" grep, makeの実行後にQuickFixを開く {{{
augroup QfCmd
  autocmd!
  autocmd QuickFixCmdPost vimgrep,grep,grepadd,make if len(getqflist()) != 0 | cwindow 8 | endif
augroup END
" }}}

" grep {{{
nnoremap <Space>f :<C-u>silent grep!<Space>
vnoremap <Space>f "zy:<C-u>silent grep! '<C-r>z'<CR>

if executable('rg')
  let &grepprg = 'rg --vimgrep'
  let &grepformat = '%f:%l:%c:%m'
elseif executable('git') && !empty(system('git rev-parse --git-dir 2>/dev/null'))
  let &grepprg = 'git grep -I --no-color --line-number --column'
  let &grepformat = '%f:%l:%c:%m'
endif
" }}}

" URLなどを開く {{{
let g:open_prg = has('mac') ? 'open' : 'xdg-open'
vnoremap <silent> <Leader>o "zy:<C-u>!<C-r>=g:open_prg<CR> <C-r>z<CR>
" }}}

" 行末までヤンク {{{
nnoremap Y y$
" }}}

" 空行を追加 {{{
nnoremap <Space><CR> mzo<Esc>`z
" }}}

" 再描画でハイライトを消す {{{
nmap <silent> <C-l> :<C-u>nohlsearch<CR>:redraw<CR>
" }}}

" 選択範囲に.で繰り返しコマンド実行する {{{
vnoremap . :normal .<CR>
" }}}

" ファイルパスをコピー {{{
command! CopyPath :let @+ = expand('%:p')
command! CopyFilename :let @+ = expand('%:t')
" }}}

" awk {{{
function! AwkPrint(line1, line2, ...)
  let args = map(copy(a:000), { _, v -> '$' .. v })
  execute printf("%d,%d!awk '{print %s}'", a:line1, a:line2, join(args, ','))
endfunction
command! -range -nargs=+ Awk :call AwkPrint(<line1>, <line2>, <f-args>)
" }}}

" abbreviations {{{
cabbrev sg silent grep!
cabbrev windi windo diffthis
cabbrev ld Linediff
cabbrev ggl SearchByGoogle
" }}}

" Google it {{{
function! s:search_by_google(...) abort
  if empty(a:000)
    return
  endif
  let url = shellescape('https://www.google.com/search?q=' .. join(a:000, '+'))
  call system(printf('%s %s', g:open_prg, url))
endfunction
command! -nargs=* SearchByGoogle call s:search_by_google(<f-args>)
nnoremap <silent> <Space>g :SearchByGoogle <C-r>=expand('<cword>')<CR><CR>
vnoremap <silent> <Space>g "zy:SearchByGoogle <C-r>z<CR>
" }}}
