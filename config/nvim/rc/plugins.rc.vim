" ultisnips {{{
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']
" }}}

" commentary {{{
nnoremap <Leader>\ :<C-u>Commentary<CR>
vnoremap <Leader>\ :Commentary<CR>
" }}}

" CtrlP {{{
if !has('nvim')
  let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
endif
let g:ctrlp_user_command = 'rg --color never --files --hidden --follow --glob "!.git/*"'
let g:ctrlp_reuse_window = 'filer'

nnoremap <silent> <Space>b :<C-u>CtrlPBuffer<CR>
nnoremap <silent> <Space>l :<C-u>CtrlPLine %<CR>
nnoremap <silent> <Space>L :<C-u>CtrlPLine<CR>

function! s:search(...)
  exe 'silent' 'grep!' join(a:000) '| cclose | CtrlPQuickfix'
endfunction
command! -nargs=+ Search :call s:search(<f-args>)
nnoremap <Space>f :<C-u>Search<Space>
nnoremap <silent> <Space>* :<C-u>Search <C-r>=expand('<cword>')<CR><CR>
" }}}

" Coc {{{
let g:coc_node_path = '/usr/local/bin/node'
let g:coc_global_extensions = [
      \   'coc-css',
      \   'coc-go',
      \   'coc-html',
      \   'coc-java',
      \   'coc-prettier',
      \   'coc-python',
      \   'coc-snippets',
      \   'coc-svelte',
      \   'coc-tailwindcss',
      \   'coc-tsserver',
      \   'coc-vimlsp',
      \ ]

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <F2> <Plug>(coc-rename)
imap <silent> <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <C-x><C-x> coc#refresh()
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

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
  if &filetype =~? '\v(javascript|typescript)'
    execute 'CocCommand prettier.formatFile'
  else
    call CocAction('format')
  endif
endfunction
" }}}

" AnyJump {{{
let g:any_jump_disable_default_keybindings = 1
nnoremap <Space>j :<C-u>AnyJump<CR>
xnoremap <Space>j :AnyJumpVisual<CR>
" }}}

" asterisk {{{
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1
" }}}

" sneak {{{
" sはsandwichが使っている
" f/tはマクロのために変更したくない
" xは結構使うので潰すと困る
" 'ならいつも`で済ませるので潰しても困らないし打ちやすい
map ' <Plug>Sneak_s
map '' <Plug>Sneak_S
let g:sneak#use_ic_scs = 1
" }}}

" pydocstring {{{
let g:pydocstring_formatter = 'google'
let g:pydocstring_enable_mapping = 0
" }}}

" emmet {{{
let g:user_emmet_mode = 'iv'
" }}}
