setlocal cursorline
setlocal nowrap

" qfから開いたときにfilerのウィンドウが残ると邪魔なので閉じる
nnoremap <silent> <buffer> <CR> <CR>:call <SID>close_filer()<CR>
" pでqfからカーソルを動かさずにファイルを開く
noremap <silent> <buffer> p  <CR>:call <SID>close_filer()<CR>zz<C-w>p

function! s:close_filer()
  let filer_winnr = bufwinnr('*/$')
  if filer_winnr >= 0
    execute filer_winnr 'wincmd q'
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
