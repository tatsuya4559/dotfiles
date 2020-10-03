setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4

function! s:gorun(...) abort
  let cmd = printf('go run %s', expand('%'))
  if !empty(a:000)
    let cmd .= ' ' . join(map(copy(a:000), 'shellescape(v:val)'), ' ')
  endif
  execute 'T' cmd
endfunction
command! -nargs=* -buffer GoRun call s:gorun(<f-args>)

function! s:errcheck() abort
  let mx = '\S\+:\d\+:\d\+:[^:]\+:[^:]\+$'
  let lines = system('errcheck ' . shellescape(expand('%:p:h')))
  cexpr join(map(split(lines, "\n"), 'matchstr(v:val, mx)'), "\n")
endfunction
command! -buffer ErrCheck call s:errcheck()

" peek methods
function! s:peek_methods()
  execute 'vimgrep /func (.* \*\?' . expand('<cword>') . ')/ %'
endfunction
command! -buffer PeekMethods call s:peek_methods()
nnoremap <buffer><silent> gm :<C-u>PeekMethods<CR>
