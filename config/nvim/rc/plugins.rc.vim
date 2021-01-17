" ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']

" commentary
nnoremap <Leader>\ :<C-u>Commentary<CR>
vnoremap <Leader>\ :Commentary<CR>

" CtrlP
let g:ctrlp_user_command = 'rg --color never --files --hidden --follow --glob "!.git/*"'
let g:ctrlp_reuse_window = 'filer'
let g:ctrlp_switch_buffer = 0
nnoremap <silent> <Space>b :<C-u>CtrlPBuffer<CR>

" Coc
let g:coc_node_path = has('mac') ? '/usr/local/bin/node' : '/usr/bin/node'
let g:coc_global_extensions = [
      \   'coc-java',
      \   'coc-python',
      \   'coc-svelte',
      \   'coc-tsserver',
      \ ]

nnoremap <Space>o :<C-u>CocList outline<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <F2> <Plug>(coc-rename)

nnoremap <silent> K :<C-u>call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype =~? '\v(vim|help)'
    execute 'h' expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> <Space>a :<C-u>CocAction<CR>

nnoremap <Leader>f :<C-u>call FormatDocument()<CR>
function! FormatDocument()
  call CocAction('format')
endfunction

" AnyJump
let g:any_jump_disable_default_keybindings = 1
nnoremap <Space>j :<C-u>AnyJump<CR>
xnoremap <Space>j :AnyJumpVisual<CR>

" asterisk
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
