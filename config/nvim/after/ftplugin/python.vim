" インデント設定 {{{
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
" }}}

" format & lint {{{
command! -buffer Black :!black %:p
command! -buffer Pylint :make!
let &l:makeprg = 'pylint --reports=n --output-format=parseable %:p'
let &l:errorformat = '%f:%l: %m'
" }}}

" DjangoTestをneotermで実行する {{{
let g:test_options = {
  \ 'portal': ['--settings=settings.bbtu.local_db', '-k'],
  \ 'texas': ['--settings=texas.settings.local_db', '-k'],
  \ 'portalapi': ['--settings=portalapi.settings.local_db'],
  \ }

function! s:get_project_name()
  " cwdがプロジェクトルートである前提
  " テスト実行コマンドがsrc/manage.py決め打ちだからこの前提でOK
  return fnamemodify(getcwd(), ':t')
endfunction

function! s:run_django_test(command)
  let options = get(g:test_options, s:get_project_name(), [])
  execute a:command join(options)
endfunction

command! DjangoTestNearest :call s:run_django_test('TestNearest')<CR>
command! DjangoTestFile :call s:run_django_test('TestFile')<CR>
command! DjangoTestLast :call s:run_django_test('TestLast')<CR>
" }}}
