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

" DjangoTestをtmuxペインで実行する {{{
let g:test_settings = {
  \ 'portal': '--settings=settings.bbtu.local',
  \ 'texas': '--settings=texas.settings.local_db',
  \ 'portalapi': '--settings=portalapi.settings.local',
  \ }

function! s:is_py3_project()
  return (index(['portal', 'texas'], s:get_project_name()) >= 0)
endfunction

function! s:get_project_name()
  " cwdがプロジェクトルートである前提
  " テスト実行コマンドがsrc/manage.py決め打ちだからこの前提でOK
  return substitute(getcwd(), '.*/', '', 'g')
endfunction

function! s:run_django_test(command)
  let options = get(g:test_settings, s:get_project_name(), '')
  if s:is_py3_project()
    let options .= ' -k'
  endif
  execute ':' . a:command . ' ' . options
endfunction

command! DjangoTestNearest :call s:run_django_test('TestNearest')<CR>
command! DjangoTestFile :call s:run_django_test('TestFile')<CR>
command! DjangoTestLast :call s:run_django_test('TestLast')<CR>
" }}}
