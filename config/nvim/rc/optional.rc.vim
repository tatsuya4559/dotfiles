let g:use_builtin_terminal = v:false
let g:enable_zoom_window = v:false
let g:enable_smooth_scroll = v:false
let g:enable_open_tig = v:false

" terminal {{{
if g:use_builtin_terminal
  tnoremap <Esc> <C-\><C-n>
  tnoremap <silent> <C-w> <C-\><C-n><C-w>
  augroup TermCmd
    autocmd!
    autocmd WinEnter,BufEnter term://* startinsert
  augroup END

  " terminal内でvimがネストしないようnvrを使う
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  augroup GitCmd
    autocmd!
    autocmd FileType gitcommit,gitrebase set bufhidden=delete
  augroup END
endif
" }}}

" Zoom Window {{{
if g:enable_zoom_window
  function! ToggleZoom()
    if exists('t:unzoom_cmd')
      " FIXME: コマンド通りに復元されない場合がある
      " vimのバグ??
      execute t:unzoom_cmd
      unlet t:unzoom_cmd
    else
      let t:unzoom_cmd = winrestcmd()
      wincmd _
      wincmd |
    endif
  endfunction
  nnoremap <silent> <Space>z :call ToggleZoom()<CR>
endif
" }}}

" smooth scroll {{{
" thanks to cohama
if g:enable_smooth_scroll
  let s:scroll_time_ms = 100
  let s:scroll_precision = 8
  function! SmoothScroll(dir, windiv, factor)
    let cl = &cursorline
    let cc = &cursorcolumn
    set nocursorline nocursorcolumn
    let height = winheight(0) / a:windiv
    let n = height / s:scroll_precision
    if n <= 0
      let n = 1
    endif
    let wait_per_one_move_ms = s:scroll_time_ms / s:scroll_precision * a:factor
    let i = 0
    let scroll_command = a:dir == "down" ?
          \ "normal! " .. n .. "\<C-e>" .. n .. "j" :
          \ "normal! " .. n .. "\<C-y>" .. n .. "k"
    while i < s:scroll_precision
      let i = i + 1
      execute scroll_command
      execute "sleep" wait_per_one_move_ms "m"
      redraw
    endwhile
    let &cursorline = cl
    let &cursorcolumn = cc
  endfunction
  nnoremap <silent><expr> <C-d> v:count == 0 ? ":call SmoothScroll('down', 2, 1)\<CR>" : "\<C-d>"
  nnoremap <silent><expr> <C-u> v:count == 0 ? ":call SmoothScroll('up', 2, 1)\<CR>" : "\<C-u>"
  nnoremap <silent><expr> <C-f> v:count == 0 ? ":call SmoothScroll('down', 1, 2)\<CR>" : "\<C-f>"
  nnoremap <silent><expr> <C-b> v:count == 0 ? ":call SmoothScroll('up', 1, 2)\<CR>" : "\<C-b>"
endif
" }}}

" tigを開く {{{
" neotermの最後に使ったterminalとしてカウントされたくないから
" 普通のterminalコマンドで開く
if g:enable_open_tig
  function! OpenTig()
    let s:tig_bufname = bufname('term://*:tig')
    if bufexists(s:tig_bufname)
      let tig_winnr = bufwinnr(s:tig_bufname)
      if tig_winnr >= 0
        execute tig_winnr 'wincmd w'
      else
        execute 'buffer' s:tig_bufname
      endif
    else
      execute 'terminal tig status'
      setlocal nonumber
      setlocal norelativenumber
      " Qでtigを閉じずにもとのバッファに戻る
      tnoremap <buffer> Q <C-\><C-n><C-^>
      tnoremap <buffer> <C-w> <C-\><C-n><C-w>
    endif
    startinsert
  endfunction
  nnoremap <Space>t :<C-u>call OpenTig()<CR>
endif
" }}}
