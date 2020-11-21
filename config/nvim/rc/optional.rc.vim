let g:use_builtin_terminal = 1
" let g:enable_zoom_window = 1
" let g:enable_smooth_scroll = 1
" let g:enable_open_tig = 1
let g:enable_change_case = 1
" let g:enable_im_ctrl = 1

" terminal {{{
if get(g:, 'use_builtin_terminal', 0)
  tnoremap <Esc> <C-\><C-n>
  tnoremap <silent> <C-w> <C-\><C-n><C-w>
  augroup TermCmd
    autocmd!
    autocmd WinEnter,BufEnter term://* startinsert | setlocal nonumber norelativenumber
  augroup END

  " terminal内でvimがネストしないようnvrを使う
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  augroup GitCmd
    autocmd!
    autocmd FileType gitcommit,gitrebase set bufhidden=delete
  augroup END
endif
" }}}

" Zoom Window {{{
if get(g:, 'enable_zoom_window', 0)
  function! ToggleZoom()
    if exists('t:unzoom_cmd')
      " FIXME: コマンド通りに復元されない場合がある
      " vimのバグ??
      execute t:unzoom_cmd
      unlet t:unzoom_cmd
    else
      let t:unzoom_cmd = winrestcmd()
      wincmd _
      wincmd |
    endif
  endfunction
  nnoremap <silent> <Space>z :call ToggleZoom()<CR>
endif
" }}}

" smooth scroll {{{
" thanks to cohama
if get(g:, 'enable_smooth_scroll', 0)
  let s:scroll_time_ms = 100
  let s:scroll_precision = 8
  function! SmoothScroll(dir, windiv, factor)
    let cl = &cursorline
    let cc = &cursorcolumn
    set nocursorline nocursorcolumn
    let height = winheight(0) / a:windiv
    let n = height / s:scroll_precision
    if n <= 0
      let n = 1
    endif
    let wait_per_one_move_ms = s:scroll_time_ms / s:scroll_precision * a:factor
    let i = 0
    let scroll_command = a:dir == "down" ?
          \ "normal! " .. n .. "\<C-e>" .. n .. "j" :
          \ "normal! " .. n .. "\<C-y>" .. n .. "k"
    while i < s:scroll_precision
      let i = i + 1
      execute scroll_command
      execute "sleep" wait_per_one_move_ms "m"
      redraw
    endwhile
    let &cursorline = cl
    let &cursorcolumn = cc
  endfunction
  nnoremap <silent><expr> <C-d> v:count == 0 ? ":call SmoothScroll('down', 2, 1)\<CR>" : "\<C-d>"
  nnoremap <silent><expr> <C-u> v:count == 0 ? ":call SmoothScroll('up', 2, 1)\<CR>" : "\<C-u>"
  nnoremap <silent><expr> <C-f> v:count == 0 ? ":call SmoothScroll('down', 1, 2)\<CR>" : "\<C-f>"
  nnoremap <silent><expr> <C-b> v:count == 0 ? ":call SmoothScroll('up', 1, 2)\<CR>" : "\<C-b>"
endif
" }}}

" tigを開く {{{
if get(g:, 'enable_open_tig', 0)
  function! OpenTig()
    let s:tig_bufname = bufname('term://*:tig')
    if bufexists(s:tig_bufname)
      let tig_winnr = bufwinnr(s:tig_bufname)
      if tig_winnr >= 0
        execute tig_winnr 'wincmd w'
      else
        execute 'buffer' s:tig_bufname
      endif
    else
      execute 'terminal tig status'
      setlocal nonumber
      setlocal norelativenumber
      " Qでtigを閉じずにもとのバッファに戻る
      tnoremap <buffer> Q <C-\><C-n><C-^>
      tnoremap <buffer> <C-w> <C-\><C-n><C-w>
    endif
    startinsert
  endfunction
  nnoremap <Space>t :<C-u>call OpenTig()<CR>
endif
" }}}

" ケース変換 {{{
if get(g:, 'enable_change_case', 0)
  function! s:determine_case(word) abort
    " 大文字を含まない
    if a:word =~# '^[^A-Z]\+$'
      return 'snake'
    " 小文字を含まない
    elseif a:word =~# '^[^a-z]\+$'
      return 'upper'
    " 1文字目が小文字
    elseif a:word[0] =~# '[a-z]'
      return 'camel'
    else
      return 'pascal'
    endif
  endfunction

  function! s:split_token(word) abort
    let l:case = s:determine_case(a:word)

    if l:case ==# 'snake'
      return split(a:word, '_')
    elseif l:case ==# 'upper'
      return map(split(a:word, '_'), {_, t -> tolower(t)})
    else
      return map(split(a:word, '\zs\ze[A-Z]'), {_, t -> tolower(t)})
    endif
  endfunction

  function! ToSnakeCase() abort
    let l:word = expand('<cword>')
    let l:tokens = s:split_token(l:word)
    let l:snake = join(l:tokens, '_')
    call setline('.', substitute(getline('.'), l:word, l:snake, ''))
  endfunction

  function! ToUpperCase() abort
    let l:word = expand('<cword>')
    let l:tokens = s:split_token(l:word)
    let l:upper = join(map(l:tokens, {_, t -> toupper(t)}), '_')
    call setline('.', substitute(getline('.'), l:word, l:upper, ''))
  endfunction

  function! ToCamelCase() abort
    let l:word = expand('<cword>')
    let l:tokens = s:split_token(l:word)
    let l:camel = join(map(l:tokens, {_, t -> toupper(t[0]) .. t[1:]}), '')
    let l:camel = tolower(l:camel[0]) .. l:camel[1:]
    call setline('.', substitute(getline('.'), l:word, l:camel, ''))
  endfunction

  function! ToPascalCase() abort
    let l:word = expand('<cword>')
    let l:tokens = s:split_token(l:word)
    let l:pascal = join(map(l:tokens, {_, t -> toupper(t[0]) .. t[1:]}), '')
    call setline('.', substitute(getline('.'), l:word, l:pascal, ''))
  endfunction

  command! ToSnake call ToSnakeCase()
  command! ToUpper call ToUpperCase()
  command! ToCamel call ToCamelCase()
  command! ToPascal call ToPascalCase()
endif
" }}}

" 日本語固定モード(fcitx only) {{{
if get(g:, 'enable_im_ctrl', 0)

  if executable('fcitx-remote')
    let g:im_commands = {
          \ 'status': '[[ $(fcitx-remote) == 1 ]] && echo -n inactive || echo -n active',
          \ 'activate': 'fcitx-remote -o > /dev/null 2>&1',
          \ 'deactivate': 'fcitx-remote -c > /dev/null 2>&1',
          \ }
  endif

  let g:kana_mode = 0

  function! s:toggle_kana_mode() abort
    let g:kana_mode = !get(g:, 'kana_mode', v:false)
    if g:kana_mode
      set statusline=日本語固定モード
    else
      set statusline=
    endif
  endfunction
  command! ToggleKanaMode call s:toggle_kana_mode()
  nnoremap <Leader>k :ToggleKanaMode<CR>

  augroup IMCtrl
    autocmd!
    autocmd InsertEnter * call s:activate_im()
    autocmd InsertLeave * call s:deactivate_im()
  augroup END

  function! s:deactivate_im() abort
    if s:get_im_state() ==# 'active'
      call system(g:im_commands['deactivate'])
    endif
  endfunction

  function! s:activate_im() abort
    if !get(g:, 'kana_mode', v:false)
      return
    endif

    if s:get_im_state() ==# 'inactive'
      call system(g:im_commands['activate'])
    endif
  endfunction

  function! s:get_im_state() abort
    return system(g:im_commands['status'])
  endfunction
endif
" }}}
