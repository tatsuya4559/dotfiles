" auto pairs {{{
let g:AutoPairsShortcutFastWrap = '<C-l>'
" }}}

" ultisnips {{{
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']
" }}}

" buftabline {{{
let g:buftabline_show = 1
let g:buftabline_numbers = 1
" }}}

" commentary {{{
nnoremap <Leader>\ :<C-u>Commentary<CR>
vnoremap <Leader>\ :Commentary<CR>
" }}}

" vaffle {{{
nnoremap <Space>v :<C-u>Vaffle<CR>
nnoremap <Space><Space> :<C-u>Vaffle %:h<CR>
" }}}

" fzf {{{
let g:fzf_preview_window = ''
nnoremap <silent> <C-p> :<C-u>GFiles<CR>
nnoremap <silent> <Space>b :<C-u>Buffers<CR>
nnoremap <silent> <Space>c :<C-u>Commands<CR>
nnoremap <silent> <Space>l :<C-u>BLines<CR>
nnoremap <silent> <Space>L :<C-u>Lines<CR>
nnoremap <Space>f :<C-u>Rg<Space>
nnoremap <silent> <Space>* :<C-u>Rg <C-r>=expand('<cword>')<CR><CR>
" }}}

" CocFzf {{{
nnoremap <silent> <Space>o  :<C-u>CocFzfList outline<CR>
" }}}

" Coc {{{
let g:coc_global_extensions = [
      \   'coc-actions',
      \   'coc-css',
      \   'coc-emmet',
      \   'coc-go',
      \   'coc-html',
      \   'coc-java',
      \   'coc-prettier',
      \   'coc-python',
      \   'coc-rls',
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
nmap <F2> <Plug>(coc-rename)
nnoremap <silent> K :<C-u>call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> <Space>a :<C-u>CocCommand actions.open<CR>

nnoremap <Leader>f :<C-u>call FormatDocument()<CR>
function! FormatDocument()
  if &ft =~? 'javascript\|typescript'
    execute 'CocCommand prettier.formatFile'
  else
    call CocAction('format')
  endif
endfunction

nnoremap <Leader>g :<C-u>CocDiagnostics<CR>

inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

imap <silent> <C-j> <Plug>(coc-snippets-expand-jump)
" }}}

" AnyJump {{{
let g:any_jump_disable_default_keybindings = 1
nnoremap <Space>j :<C-u>AnyJump<CR>
xnoremap <Space>j :AnyJumpVisual<CR>
" }}}

" Tmux Navigator {{{
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-h> :<C-u>TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :<C-u>TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :<C-u>TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :<C-u>TmuxNavigateRight<CR>
" }}}

" vim-test {{{
let g:test#strategy = 'vimux'
let g:test#python#runner = 'djangotest'
let g:test#python#djangotest#executable = 'python src/manage.py test'
" }}}

" asterisk {{{
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1
" }}}
