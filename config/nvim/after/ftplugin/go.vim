setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4
set listchars=tab:\ \ ,trail:-,nbsp:+

function! s:errcheck() abort
  let mx = '\S\+:\d\+:\d\+:[^:]\+:[^:]\+$'
  let lines = system('errcheck ' . shellescape(expand('%:p:h')))
  cexpr join(map(split(lines, "\n"), 'matchstr(v:val, mx)'), "\n")
endfunction
command! -buffer ErrCheck call s:errcheck()

" peek methods
function! s:peek_methods()
  execute 'vimgrep /func (.* \*\?' .. expand('<cword>') .. ')/ %'
endfunction
command! -buffer PeekMethods call s:peek_methods()
nnoremap <buffer><silent> gm :<C-u>PeekMethods<CR>

function! s:gofmt() abort
  cexpr system(printf('go fmt %s', expand('%'))) | cw
endfunction
command! GoFmt call s:gofmt()

function! s:gobuild() abort
  cexpr system(printf('go build %s', expand('%'))) | cw
endfunction
command! GoBuild call s:gobuild()

command! -buffer Run :bo split term://go run %
nnoremap <Leader>r :<C-u>Run<CR>
