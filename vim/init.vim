"   __  ___       _      _ __        _
"  /  |/  /_ __  (_)__  (_) /_ _  __(_)_ _
" / /|_/ / // / / / _ \/ / __/| |/ / /  ' \
"/_/  /_/\_, / /_/_//_/_/\__(_)___/_/_/_/_/
"       /___/

"================================================================================
" 方針
" vimはプラグイン管理に消耗したくないから、最小限のものだけ入れておく。
" 各言語別の補完や、デバッグなどはIDEに任せる。
" InteriJのプラグインがない言語はvimでLSPとか使う。
"================================================================================
let g:rc_dir = expand('~/.vim/rc')

function! s:source_rc(rc_file_name)
    let rc_file = expand(g:rc_dir . '/' . a:rc_file_name)
    if filereadable(rc_file)
        execute 'source' rc_file
    endif
endfunction

call s:source_rc('dein.rc.vim')
call s:source_rc('basic.rc.vim')
call s:source_rc('mappings.rc.vim')
call s:source_rc('plugins.rc.vim')

"================================================================================
" colorscheme and encoding
"================================================================================
"colors
colorscheme desert
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ }

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,dos,mac

" TODO:
" * session util
" * abbreviation
