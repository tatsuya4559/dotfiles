"================================================================================
" plugin settings
"================================================================================
" vim-multiple-cursors ----------------------------------------------------------
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_start_word_key      = '<M-d>'
let g:multi_cursor_next_key            = '<M-d>'
let g:multi_cursor_skip_key            = '<M-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" vim-sandwitch -----------------------------------------------------------------
vmap ' sa'
vmap " sa"
vmap ( sa(
vmap ) sa)

" commentary --------------------------------------------------------------------
nnoremap <Space>c :<C-u>Commentary<CR>
vnoremap <Space>c :Commentary<CR>

" indentLine --------------------------------------------------------------------
let g:indentLine_char = '▏'
let g:indentLine_first_char = '▏'
let g:indentLine_showFirstIndentLevel = 1
let g:vim_json_syntax_conceal = 0

" anzu --------------------------------------------------------------------------
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" submode -----------------------------------------------------------------------
call submode#enter_with('window', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('window', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('window', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('window', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('window', 'n', '', '>', '<C-w>>')
call submode#map('window', 'n', '', '<', '<C-w><')
call submode#map('window', 'n', '', '+', '<C-w>+')
call submode#map('window', 'n', '', '-', '<C-w>-')

call submode#enter_with('resize', 'n', '', '>>', '>>')
call submode#enter_with('resize', 'n', '', '<<', '<<')
call submode#map('resize', 'n', '', '>', '>>')
call submode#map('resize', 'n', '', '<', '<<')

call submode#enter_with('z', 'n', '', 'zl', 'zl')
call submode#enter_with('z', 'n', '', 'zh', 'zh')
call submode#map('z', 'n', '', 'l', 'zl')
call submode#map('z', 'n', '', 'h', 'zh')

" FixWhitespace -----------------------------------------------------------------
" autocmd BufWritePre * :FixWhitespace

" Tag bar ----------------------------------------------------------------------
nnoremap <Space>t :TagbarToggle<CR>

" fzf ---------------------------------------------------------------------------
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'

  function! FloatingFZF()
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
               \ 'row': (&lines - height) / 2,
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height }
    let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
else
  let g:fzf_layout = { 'up': '~60%' }
endif

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

function! RipgrepPreview(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RgP call RipgrepPreview(<q-args>, <bang>0)

nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-c> :Commands<CR>
nnoremap <silent> <Space>b :Buffers<CR>
nnoremap <silent> <Space>l :BLines<CR>
nnoremap <silent> <Space>L :Lines<CR>
nnoremap <silent> <Space>f :Rg<CR>
nnoremap <silent> <Space>F :RgP<CR>
nnoremap <silent> <Space>s :GFiles?<CR>

vnoremap <silent> <C-p> "zy:GFiles<CR><C-\><C-n>"zpi
vnoremap <silent> <Space>b "zy:Buffers<CR><C-\><C-n>"zpi
vnoremap <silent> <Space>l "zy:BLines<CR><C-\><C-n>"zpi
vnoremap <silent> <Space>L "zy:Lines<CR><C-\><C-n>"zpi
vnoremap <silent> <Space>f "zy:Rg<CR><C-\><C-n>"zpi
vnoremap <silent> <Space>F "zy:RgP<CR><C-\><C-n>"zpi

" Coc ---------------------------------------------------------------------------
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)
"nmap <Nop> <Plug>(coc-format)
nnoremap <silent> <Space>o  :<C-u>CocList outline<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <Space>e :<C-u>CocCommand explorer --toggle --sources=buffer+,file+<CR>
nnoremap <silent> <space>t  :<C-u>CocList -I symbols<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <silent> <C-j> <Plug>(coc-snippets-expand-jump)

" fugitive ---------------------------------------------------------------------
nmap [fugitive] <Nop>
map <Space>g [fugitive]
nnoremap [fugitive]s :<C-u>Gstatus<CR>
nnoremap [fugitive]d :<C-u>Gvdiff<CR>
nnoremap [fugitive]b :<C-u>Gblame<CR>
nnoremap [fugitive]w :<C-u>Gbrowse<CR>
vnoremap [fugitive]w :Gbrowse<CR>

" emmet -------------------------------------------------------------------------
let g:user_emmet_leader_key='<C-t>'

" Async Run ---------------------------------------------------------------------
let g:asyncrun_open = 8
nnoremap <Space>3 :<C-u>AsyncRun
" for bbt
nnoremap <Space>4 :<C-u>AsyncStop
nnoremap <Space>5 :<C-u>AsyncRun makers run bbtu
nnoremap <Space>6 :<C-u>AsyncRun makers test bbt.lp.
nnoremap <Space>7 :<C-u>AsyncRun black %
nnoremap <Space>8 :<C-u>AsyncRun flake8 %<CR>
