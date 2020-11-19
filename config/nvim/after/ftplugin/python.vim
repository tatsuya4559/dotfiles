setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4

" format & lint
command! -buffer Black :!black %:p
command! -buffer Pylint :make!
let &l:makeprg = 'pylint --reports=n --output-format=parseable %:p'
let &l:errorformat = '%f:%l: %m'

" let g:py_repl_prg = 'ipython'
function! s:start_repl() abort
  let l:prg = get(g:, 'py_repl_prg', 'python')
  exe printf('bo split term://%s', l:prg)
endfunction
command! -buffer REPL call s:start_repl()
