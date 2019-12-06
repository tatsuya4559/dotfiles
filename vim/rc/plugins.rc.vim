"================================================================================
" plugin settings
"================================================================================

" FixWhitespace -----------------------------------------------------------------
" autocmd BufWritePre * :FixWhitespace

" NerdTree ----------------------------------------------------------------------
nnoremap <Leader>e :NERDTreeToggle<CR>

" Tag bar ----------------------------------------------------------------------
nnoremap <Leader>t :TagbarToggle<CR>

" fzf ---------------------------------------------------------------------------
let g:fzf_layout = { 'up': '~60%' }

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-c> :Commands<CR>
nnoremap <silent> <space>f :Files<CR>
nnoremap <silent> <space>b :Buffers<CR>
nnoremap <silent> <space>l :BLines<CR>
nnoremap <silent> <space>g :Rg<CR>
nnoremap <silent> <space>s :GFiles?<CR>

vnoremap <silent> <C-p> "zy:GFiles<CR><C-\><C-n>"zpi
vnoremap <silent> <space>f "zy:Files<CR><C-\><C-n>"zpi
vnoremap <silent> <space>b "zy:Buffers<CR><C-\><C-n>"zpi
vnoremap <silent> <space>l "zy:BLines<CR><C-\><C-n>"zpi
vnoremap <silent> <space>g "zy:Rg<CR><C-\><C-n>"zpi

" ALE ---------------------------------------------------------------------------
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'python': ['black'],
  \ }
let g:ale_fix_on_save = 1

" Coc ---------------------------------------------------------------------------
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <Nop> <Plug>(coc-references)
nmap <silent> <Nop> <Plug>(coc-rename)
nmap <silent> <Nop> <Plug>(coc-format)
nnoremap <silent> <space>o  :<C-u>CocList outline<CR>
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
nmap <silent> [fugitive]b :<C-u>Gblame<CR>
