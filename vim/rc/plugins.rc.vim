"================================================================================
" plugin settings
"================================================================================

" deoplete ----------------------------------------------------------------------
let g:deoplete#eneble_at_startup = 1

" FixWhitespace -----------------------------------------------------------------
autocmd BufWritePre * :FixWhitespace

" NerdTree ----------------------------------------------------------------------
nnoremap <Leader>e :NERDTreeToggle<CR>

" Tag bar -----------------------------------------------------------------------
nnoremap <Leader>t :TagbarToggle<CR>

" fzf ---------------------------------------------------------------------------
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <space>p :Files<CR>
nnoremap <silent> <space>b :Buffers<CR>
nnoremap <silent> <space>l :BLines<CR>
nnoremap <silent> <space>f :Rg<CR>
nnoremap <silent> <C-c> :Commands<CR>

" ALE ---------------------------------------------------------------------------
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'python': ['black'],
  \ }
let g:ale_fix_on_save = 1

" fugitive ----------------------------------------------------------------------
nmap [fugitive] <Nop>
map <Leader>g [fugitive]
nmap <silent> [fugitive]s :<C-u>Gstatus<CR>
nmap <silent> [fugitive]d :<C-u>Gvdiff<CR>
