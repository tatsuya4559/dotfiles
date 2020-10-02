nmap <buffer> h <Plug>(filer-up)
nmap <buffer> l <Plug>(filer-down)

" 編集用バッファを別に用意すると便利
function! s:as_new_buf() abort
  let l:lines = getline('1', '$')
  split [command]
  setlocal filetype=sh buftype=nofile bufhidden=wipe nobuflisted noswapfile
  call setline(1, l:lines)
endfunction
nnoremap <buffer> X :call <SID>as_new_buf()<CR>
