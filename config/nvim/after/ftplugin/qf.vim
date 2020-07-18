setlocal cursorline
setlocal nowrap

" qfから開いたときにvaffleのウィンドウが残ると邪魔なので閉じる
nnoremap <silent> <buffer> <CR> :call <SID>open()<CR>
" pでqfからカーソルを動かさずにファイルを開く
noremap <silent> <buffer> p  :call <SID>open()<CR>zz<C-w>p

function! s:open()
  execute '.cc'
  let vaffle_winnr = bufwinnr('vaffle://*')
  if vaffle_winnr >= 0
    execute vaffle_winnr . 'wincmd q'
  endif
endfunction

" quickfixリストの削除とundoを実現する
nnoremap <silent> <buffer> dd :call <SID>del_entry()<CR>
vnoremap <silent> <buffer> d :call <SID>del_entry()<CR>
nnoremap <silent> <buffer> u :<C-u>call <SID>undo_entry()<CR>

if exists('*s:undo_entry')
  finish
endif

function! s:undo_entry()
  let history = get(w:, 'qf_history', [])
  if !empty(history)
    call setqflist(remove(history, -1), 'r')
  endif
endfunction

function! s:del_entry() range
  let qf = getqflist()
  let history = get(w:, 'qf_history', [])
  call add(history, copy(qf))
  let w:qf_history = history
  unlet! qf[a:firstline - 1 : a:lastline - 1]
  call setqflist(qf, 'r')
  execute a:firstline
endfunction
