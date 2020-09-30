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
let g:test_settings = {
  \ 'portal': ['--settings=settings.bbtu.local_db'],
  \ 'texas': ['--settings=texas.settings.local_db'],
  \ 'portalapi': ['--settings=portalapi.settings.local_db'],
  \ }

function! s:is_py3_project()
  return s:get_project_name() =~# 'portal\|texas'
endfunction

function! s:get_project_name()
  " cwdがプロジェクトルートである前提
  " テスト実行コマンドがsrc/manage.py決め打ちだからこの前提でOK
  return split(getcwd(), '/')[-1]
endfunction

function! s:run_django_test(command)
  let options = get(g:test_settings, s:get_project_name(), '')
  if s:is_py3_project()
    call add(options, '-k')
  endif
  execute a:command join(options)
endfunction

command! DjangoTestNearest :call s:run_django_test('TestNearest')<CR>
command! DjangoTestFile :call s:run_django_test('TestFile')<CR>
command! DjangoTestLast :call s:run_django_test('TestLast')<CR>
" }}}
