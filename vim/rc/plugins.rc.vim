"================================================================================
" plugin settings
"================================================================================

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

" Coc ---------------------------------------------------------------------------
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> <C-h> <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" fugitive ----------------------------------------------------------------------
nmap [fugitive] <Nop>
map <Leader>g [fugitive]
nmap <silent> [fugitive]s :<C-u>Gstatus<CR>
nmap <silent> [fugitive]d :<C-u>Gvdiff<CR>

" neoterm -----------------------------------------------------------------------
let g:neoterm_default_mod='belowright'
let g:neoterm_size=10
let g:neoterm_autoscroll=1
tnoremap <silent> <C-w> <C-\><C-n><C-w>
nnoremap <silent> <C-x> :TREPLSendLine<CR>
vnoremap <silent> <C-x> V:TREPLSendSelection<CR>
