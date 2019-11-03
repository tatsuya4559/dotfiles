"================================================================================
" plugin settings
"================================================================================

" denite ------------------------------------------------------------------------
nnoremap [denite] <Nop>
nmap <C-j> [denite]

" 再帰無しでファイル検索
nnoremap <silent> [denite]f :<C-u>Denite file<CR>
" プロジェクト内のファイル検索
nnoremap <silent> [denite]r :<C-u>Denite file/rec<CR>
" バッファに展開中のファイル検索
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
" ファイル内の関数/クラス等の検索
nnoremap <silent> [denite]o :<C-u>Denite outline<CR>
" バッファに展開中の行を検索
nnoremap <silent> [denite]l :<C-u>Denite line<CR>

nnoremap <silent> [denite]g :<C-u>Denite grep -auto-preview<CR>

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

" 上下移動を<C-n>, <C-p>
call denite#custom#map('normal', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('normal', '<C-p>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
" 入力履歴移動を<C-j>, <C-k>
call denite#custom#map('insert', '<C-j>', '<denite:assign_next_text>')
call denite#custom#map('insert', '<C-k>', '<denite:assign_previous_text>')
" 横割りオープンを`<C-s>`
call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>')
" 縦割りオープンを`<C-v>`
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>')
" タブオープンを`<C-t>`
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>')

" file/rec検索時にfuzzymatchを有効にし、検索対象から指定のファイルを除外
call denite#custom#source(
    \ 'file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'])

" 検索対象外のファイル指定
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

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
nmap <silent> [fugitive]d :<C-u>Gdiff<CR>
nmap <silent> [fugitive]b :<C-u>Gblame<CR>
nmap <silent> [fugitive]l :<C-u>Glog<CR>
