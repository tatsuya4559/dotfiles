setlocal cursorline
setlocal nowrap

" qfから開いたときにfilerのウィンドウが残ると邪魔なので閉じる
nnoremap <silent> <buffer> <CR> <CR>:call <SID>close_filer()<CR>

function! s:close_filer()
  let filer_winnr = bufwinnr('*/$')
  if filer_winnr >= 0
    execute filer_winnr 'wincmd q'
  endif
endfunction
