"================================================================================
" plugin settings
"================================================================================
" vim-multiple-cursors ----------------------------------------------------------
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_start_word_key      = '<M-d>'
let g:multi_cursor_select_all_word_key = '<M-l>'
let g:multi_cursor_next_key            = '<M-d>'
let g:multi_cursor_skip_key            = '<M-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" anzu --------------------------------------------------------------------------
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

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
nnoremap <silent> <Space>f :Files<CR>
nnoremap <silent> <Space>b :Buffers<CR>
nnoremap <silent> <Space>l :BLines<CR>
nnoremap <silent> <Space>g :Rg<CR>
nnoremap <silent> <Space>s :GFiles?<CR>
nnoremap <silent> <Space>m :Marks<CR>

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

" for snippets
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" fugitive ----------------------------------------------------------------------
nmap [fugitive] <Nop>
map <Leader>g [fugitive]
nmap <silent> [fugitive]s :<C-u>Gstatus<CR>
nmap <silent> [fugitive]d :<C-u>Gvdiff<CR>
nmap <silent> [fugitive]b :<C-u>Gblame<CR>

" emmet -------------------------------------------------------------------------
let g:user_emmet_leader_key='<C-m>'
