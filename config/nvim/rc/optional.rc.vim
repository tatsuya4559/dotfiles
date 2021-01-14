" let g:enable_zoom_window = 1
" let g:enable_smooth_scroll = 1
let g:enable_change_case = 1
" let g:enable_im_ctrl = 1
let g:enable_close_paren = 1

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
  function! s:IMEManager() abort
    let self = {}

    " properties
    let self.is_japanese_mode = v:false

    " methods
    function! self.toggle_japanese_mode() abort
      let self.is_japanese_mode = !self.is_japanese_mode
      if self.is_japanese_mode
        set statusline=日本語固定モード
      else
        set statusline=
      endif
    endfunction

    return self
  endfunction


  function! s:FcitxManager() abort
    " IMEManagerを継承
    let self = s:IMEManager()

    " methods
    function! self.is_active() abort
        return system('fcitx-remote') == 2
    endfunction

    function! self.activate() abort
      if !self.is_japanese_mode || self.is_active()
        return
      endif

      call system('fcitx-remote -o > /dev/null 2>&1')
    endfunction

    function! self.deactivate() abort
      if self.is_active()
        call system('fcitx-remote -c > /dev/null 2>&1')
      endif
    endfunction

    return self
  endfunction


  if executable('fcitx-remote')
    let g:ime_manager = s:FcitxManager()
  endif

  augroup IMECtrl
    autocmd!
    autocmd InsertEnter * call g:ime_manager.activate()
    autocmd InsertLeave * call g:ime_manager.deactivate()
  augroup END
  command! ToggleJapaneseMode call g:ime_manager.toggle_japanese_mode()
  nnoremap <Leader>k :ToggleJapaneseMode<CR>
endif
" }}}

" 閉じられていない(), [], {}を補完する {{{
if get(g:, 'enable_close_paren', 0)
  function! CloseParen() abort
    let l:closed_parens = 0
    let l:closed_brackets = 0
    let l:closed_braces = 0

    let l:line = line('.')
    let l:col = col('.') - 1

    while l:line > 0
      let l:line_string = getline(l:line)
      while l:col > 0
        let l:char = l:line_string[l:col - 1]
        let l:col -= 1

        if l:char !~# '\v(\(|\)|\[|\]|\{|\})'
          continue
        endif

        if l:char ==# '('
          if l:closed_parens <= 0
            return ')'
          else
            let l:closed_parens -= 1
          endif
        elseif l:char ==# '['
          if l:closed_brackets <= 0
            return ']'
          else
            let l:closed_brackets -= 1
          endif
        elseif l:char ==# '{'
          if l:closed_braces <= 0
            return '}'
          else
            let l:closed_braces -= 1
          endif
        elseif l:char ==# ')'
          let l:closed_parens += 1
        elseif l:char ==# ']'
          let l:closed_brackets += 1
        elseif l:char ==# '}'
          let l:closed_braces += 1
        endif
      endwhile
      let l:line -= 1
      let l:col = col([l:line, '$']) - 1
    endwhile
    return ''
  endfunction
  inoremap <silent><expr> <C-l> CloseParen()
endif
" }}}
