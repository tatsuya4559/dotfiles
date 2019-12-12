"================================================================================
" plugin settings
"================================================================================

" FixWhitespace -----------------------------------------------------------------
" autocmd BufWritePre * :FixWhitespace

" NerdTree ----------------------------------------------------------------------
nnoremap <Leader>e :NERDTreeToggle<CR>

" ranger-explore ----------------------------------------------------------------
nnoremap <silent> <C-e> :RangerOpenCurrentDir<CR>

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
nnoremap <silent> <Space>f :Files<CR>
nnoremap <silent> <Space>b :Buffers<CR>
nnoremap <silent> <Space>l :BLines<CR>
nnoremap <silent> <Space>g :Rg<CR>
nnoremap <silent> <Space>s :GFiles?<CR>

vnoremap <silent> <C-p> "zy:GFiles<CR><C-\><C-n>"zpi
vnoremap <silent> <Space>f "zy:Files<CR><C-\><C-n>"zpi
vnoremap <silent> <Space>b "zy:Buffers<CR><C-\><C-n>"zpi
vnoremap <silent> <Space>l "zy:BLines<CR><C-\><C-n>"zpi
vnoremap <silent> <Space>g "zy:Rg<CR><C-\><C-n>"zpi

" Coc ---------------------------------------------------------------------------
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <Nop> <Plug>(coc-rename)
nmap <silent> <Nop> <Plug>(coc-format)
nnoremap <silent> <Space>o  :<C-u>CocList outline<CR>
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
