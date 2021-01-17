let g:enable_change_case = 1

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

