setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4

" peek methods
function! s:peek_methods()
  execute 'vimgrep /func (.* \*\?' .. expand('<cword>') .. ')/ %'
endfunction
command! -buffer PeekMethods call s:peek_methods()
nnoremap <buffer><silent> gm :<C-u>PeekMethods<CR>
