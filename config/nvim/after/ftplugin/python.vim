setlocal tabstop=4
setlocal shiftwidth=4

" format & lint
command! -buffer Black :!black %:p
command! -buffer Pylint :make!
let &l:makeprg = 'pylint --reports=n --output-format=parseable %:p'
let &l:errorformat = '%f:%l: %m'
