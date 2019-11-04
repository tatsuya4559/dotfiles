"================================================================================
" plugin settings
"================================================================================

" denite ------------------------------------------------------------------------
nnoremap [denite] <Nop>
nmap <C-j> [denite]

nnoremap <silent> [denite]f :<C-u>Denite file<CR>
nnoremap <silent> [denite]r :<C-u>Denite file/rec<CR>
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
nnoremap <silent> [denite]o :<C-u>Denite outline<CR>
nnoremap <silent> [denite]l :<C-u>Denite line<CR>
nnoremap <silent> [denite]g :<C-u>Denite grep<CR>

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> <C-u> denite#do_map('move_up_path')
  nnoremap <silent><buffer><expr> <C-s> denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'tabopen')
endfunction

autocmd FileType denite-filter call s:denite_filter_my_setting()
function! s:denite_filter_my_setting() abort
  inoremap <silent><buffer><expr> <C-u> denite#do_map('move_up_path')
  inoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
endfunction

" use floating
let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.7
let s:denite_default_options = {
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ 'highlight_filter_background': 'NormalFloat',
    \ 'prompt': '> ',
    \ 'start_filter': v:true,
    \ }
let s:denite_option_array = []
for [key, value] in items(s:denite_default_options)
  call add(s:denite_option_array, '-'.key.'='.value)
endfor
call denite#custom#option('default', s:denite_default_options)

call denite#custom#var('file/rec', 'command',
    \ ['rg', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

" ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" 上下移動を<C-n>, <C-p>
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')

" deoplete ----------------------------------------------------------------------
let g:deoplete#eneble_at_startup = 1

" FixWhitespace -----------------------------------------------------------------
autocmd BufWritePre * :FixWhitespace

" NerdTree ----------------------------------------------------------------------
map <Leader>t :NERDTreeToggle<CR>

" fugitive ----------------------------------------------------------------------
nmap [fugitive] <Nop>
map <Leader>g [fugitive]
nmap <silent> [fugitive]s :<C-u>Gstatus<CR>
nmap <silent> [fugitive]d :<C-u>Gvdiff<CR>
nmap <silent> [fugitive]b :<C-u>Gblame<CR>
nmap <silent> [fugitive]l :<C-u>Glog<CR>
