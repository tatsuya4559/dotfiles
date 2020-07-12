" インデント設定 {{{
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
" }}}

" format & lint {{{
nnoremap <buffer> <Leader>b :<C-u>!black %<CR>
nnoremap <buffer> <Leader>l :silent make!<CR>
setlocal makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
setlocal errorformat=%f:%l:\ %m
" }}}

" テスト実行コマンドをtmuxペインに送る {{{
let g:test_settings = {
  \ 'texas': '--settings=texas.settings.local_db'
  \ }

function! s:send_keys_to_tmux(keys)
  silent execute ':!tmux send-keys -t $(cat /tmp/test-pane) ' . a:keys
  silent execute ':!tmux select-pane -t $(cat /tmp/test-pane)'
endfunction

function! s:send_python_test_command()
  let settings = get(g:test_settings, s:get_project_name(), '')

  let test_command = '"python src/manage.py test '
        \ . s:build_testcase_string() . ' ' . settings . '"'

  call s:send_keys_to_tmux(test_command)
endfunction

function! s:build_testcase_string()
  let test_class = expand('<cword>')
  let test_file = expand('%:r')
  if s:is_py3_project()
    let test_path = substitute(strpart(test_file, stridx(test_file, 'bbt')), '\/', '\.', 'g')
  else
    let test_path = ''
  endif
  return test_path . '.' . test_class
endfunction

function! s:is_py3_project()
  return (index(['portal', 'texas'], s:get_project_name()) >= 0)
endfunction

function! s:get_project_name()
  return substitute(getcwd(), '.*/', '', 'g')
endfunction

command! UnitTest :call <SID>send_python_test_command()
" }}}
