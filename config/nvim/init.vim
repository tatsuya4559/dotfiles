"   __  ___       _      _ __        _
"  /  |/  /_ __  (_)__  (_) /_ _  __(_)_ _
" / /|_/ / // / / / _ \/ / __/| |/ / /  ' \
"/_/  /_/\_, / /_/_//_/_/\__(_)___/_/_/_/_/
"       /___/

set encoding=utf-8
scriptencoding utf-8

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
let s:rc_dir = expand('~/.config/nvim/rc')

function! s:source_rc(rc_file_name)
  let rc_file = expand(s:rc_dir . '/' . a:rc_file_name)
  if filereadable(rc_file)
    execute 'source' rc_file
  endif
endfunction

call s:source_rc('basic.rc.vim')
call s:source_rc('packages.rc.vim')
call s:source_rc('user.rc.vim')
call s:source_rc('plugins.rc.vim')
call s:source_rc('local.rc.vim')
