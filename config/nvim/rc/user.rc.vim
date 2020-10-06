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
nnoremap j gj
xnoremap j gj
nnoremap k gk
xnoremap k gk

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
colorscheme nord

function! s:toggle_color()
  if g:colors_name !=# 'nord'
    execute 'colorscheme nord'
  else
    execute 'colorscheme shirotelin'
  endif
endfunction
nnoremap <silent> <F3> :<C-u>call <SID>toggle_color()<CR>
" }}}

" クリップボードを共有 {{{
" thanks to monaqa
set clipboard=

noremap <Space>p "+p
noremap <Space>P "+P
noremap! <C-r><C-r> <C-r>"
noremap! <C-r><Space> <C-r>+

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

" ウィンドウのリサイズ {{{
nnoremap <S-Left> <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up> <C-w>+
nnoremap <S-Down> <C-w>-
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
nnoremap <silent> <Leader>o :<C-u>!open %<CR>
vnoremap <silent> <Leader>o "zy:<C-u>!open <C-r>z<CR>
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

" 置換 {{{
" vim-asteriskに依存
nnoremap gss :%s/\v
nnoremap gs. :s/\v
nnoremap gs* :%s/\V<C-r><C-w>
vnoremap gss :s/\v
vnoremap gs* "zy:%s/\V<C-r>z
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
  call system('open ' .. url)
endfunction
command! -nargs=* SearchByGoogle call s:search_by_google(<f-args>)
nnoremap <silent> <Space>g :SearchByGoogle <C-r>=expand('<cword>')<CR><CR>
vnoremap <silent> <Space>g "zy:SearchByGoogle <C-r>z<CR>
" }}}

" 閉じられていない(), [], {}を補完する {{{
function! CloseParen(findstart, base) abort
  if a:findstart
    return col('.') - 1
  endif

  let l:closed_parens = 0
  let l:closed_brackets = 0
  let l:closed_braces = 0

  let l:line = line('.')
  let l:col = col('.') - 1

  while l:line > 0
    let l:line_string = getline(l:line)
    while l:col > 0
      let l:char = l:line_string[l:col - 1]
      let l:col -= 1

      if l:char !~# '\v(\(|\)|\[|\]|\{|\})'
        continue
      endif

      if l:char ==# '('
        if l:closed_parens <= 0
          return [')']
        else
          let l:closed_parens -= 1
        endif
      elseif l:char ==# '['
        if l:closed_brackets <= 0
          return [']']
        else
          let l:closed_brackets -= 1
        endif
      elseif l:char ==# '{'
        if l:closed_braces <= 0
          return ['}']
        else
          let l:closed_braces -= 1
        endif
      elseif l:char ==# ')'
        let l:closed_parens += 1
      elseif l:char ==# ']'
        let l:closed_brackets += 1
      elseif l:char ==# '}'
        let l:closed_braces += 1
      endif
    endwhile
    let l:line -= 1
    let l:col = col([l:line, '$']) - 1
  endwhile
  return []
endfunction
set completefunc=CloseParen
imap <C-l> <C-x><C-u>
" }}}
