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
" Rgコマンドでrgのオプションを渡せるように
" デフォルトのコマンドからshellescape()を取り除いた
command! -bang -nargs=* Rg call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case "
  \ . <q-args>, 1, <bang>0)
let g:fzf_preview_window = ''
nnoremap <silent> <C-p> :<C-u>Files<CR>
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
let g:coc_node_path = '/usr/local/bin/node'
let g:coc_global_extensions = [
      \   'coc-actions',
      \   'coc-css',
      \   'coc-emmet',
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
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
nmap <F2> <Plug>(coc-rename)
imap <silent> <C-j> <Plug>(coc-snippets-expand-jump)

nnoremap <Leader>g :<C-u>CocDiagnostics<CR>
inoremap <silent><expr> <C-x><C-x> coc#refresh()
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

nnoremap <silent> K :<C-u>call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h ' expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" nnoremap <silent> <Space>a :<C-u>CocCommand actions.open<CR>
nnoremap <silent> <Space>a :<C-u>CocAction<CR>

nnoremap <Leader>f :<C-u>call FormatDocument()<CR>
function! FormatDocument()
  if &ft =~? 'javascript\|typescript'
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

" vim-test {{{
let g:test#strategy = 'neoterm'
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

" vista {{{
let g:vista#renderer#enable_icon = 0
let g:vista_executive_for = {
  \ 'go': 'coc',
  \ 'python': 'coc',
  \ 'java': 'coc',
  \ 'javascript': 'coc',
  \ 'typescript': 'coc',
  \ }
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

" neoterm {{{
let g:neoterm_automap_keys = '<Leader>tt'
let g:neoterm_default_mod='botright'
let g:neoterm_autoinsert = 1
let g:neoterm_autoscroll=1
nnoremap <C-j> :botright Ttoggle<CR>
nnoremap <C-k> :vertical Ttoggle<CR>
tnoremap <C-j> <C-\><C-n>:Ttoggle<CR>
tnoremap <C-k> <C-\><C-n>:Ttoggle<CR>
tnoremap <M-[> <C-\><C-n>:Tprevious<CR>
tnoremap <M-]> <C-\><C-n>:Tnext<CR>
" }}}

" pydocstring {{{
let g:pydocstring_formatter = 'google'
let g:pydocstring_enable_mapping = 0
" }}}

nmap <leader>c <Plug>(gswitch-open)
