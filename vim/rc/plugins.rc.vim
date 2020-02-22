"================================================================================
" plugin settings
"================================================================================
" ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']

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

" nerdtree ----------------------------------------------------------------------
nnoremap <silent> <Space>e :<C-u>NERDTreeToggle<CR>
nnoremap <silent> <Space>nf :<C-u>NERDTreeFind<CR>
let g:NERDTreeMapOpenVSplit = '<C-v>'
let g:NERDTreeMapOpenSplit = '<C-s>'

" Vaffle ------------------------------------------------------------------------
nnoremap <Leader>e :<C-u>Vaffle .<CR>
nnoremap <Leader>c :<C-u>Vaffle %:h<CR>

" submode -----------------------------------------------------------------------
call submode#enter_with('window', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('window', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('window', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('window', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('window', 'n', '', '>', '<C-w>>')
call submode#map('window', 'n', '', '<', '<C-w><')
call submode#map('window', 'n', '', '+', '<C-w>+')
call submode#map('window', 'n', '', '-', '<C-w>-')

call submode#enter_with('indent', 'n', '', '>>', '>>')
call submode#enter_with('indent', 'n', '', '<<', '<<')
call submode#map('indent', 'n', '', '>', '>>')
call submode#map('indent', 'n', '', '<', '<<')

call submode#enter_with('z', 'n', '', 'zl', 'zl')
call submode#enter_with('z', 'n', '', 'zh', 'zh')
call submode#map('z', 'n', '', 'l', 'zl')
call submode#map('z', 'n', '', 'h', 'zh')

" FixWhitespace -----------------------------------------------------------------
" autocmd BufWritePre * :FixWhitespace

" Tag bar ----------------------------------------------------------------------
nnoremap <Space>O :TagbarToggle<CR>

" fzf ---------------------------------------------------------------------------
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --reverse --border --margin=0,2'

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

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-c> :Commands<CR>
nnoremap <silent> <Space>b :Buffers<CR>
nnoremap <silent> <Space>l :BLines<CR>
nnoremap <silent> <Space>L :Lines<CR>
nnoremap <silent> <Space>f :Rg<CR>
nnoremap <silent> <Space>F :RgP<CR>
nnoremap <silent> <Space>h :History<CR>

vnoremap <silent> <C-p> "zy:Files<CR><C-\><C-n>"zpi
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
" nnoremap <Leader>f :<C-u>CocCommand prettier.formatFile<CR>
nnoremap <Leader>f :call <SID>format_document()<CR>
nnoremap <silent> <Space>o  :<C-u>CocList outline<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <Space>t  :<C-u>CocList -I symbols<CR>

function! s:format_document()
  if &ft =~? 'javascript\|typescript'
    execute 'CocCommand prettier.formatFile'
  elseif &ft =~? 'python'
  endif
endfunction

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

" Git ---------------------------------------------------------------------
nmap [git] <Nop>
map <Space>g [git]
nnoremap [git]s :<C-u>TigStatus<CR>
nnoremap [git]p :<C-u>call <SID>async_git_pull()<CR>
nnoremap [git]P :<C-u>call <SID>async_git_push()<CR>
nnoremap [git]d :<C-u>Gvdiff<CR>
nnoremap [git]b :<C-u>Gblame<CR>
nnoremap [git]w :<C-u>Gbrowse<CR>
vnoremap [git]w :Gbrowse<CR>
nnoremap [git]l :<C-u>Lazygit<CR>

function! s:async_git_pull()
  execute 'AsyncRun git pull origin ' . fugitive#head()
endfunction

function! s:async_git_push()
  execute 'AsyncRun git push origin HEAD'
endfunction

" emmet -------------------------------------------------------------------------
let g:user_emmet_mode='i'
let g:user_emmet_leader_key='<C-t>'

" Async Run ---------------------------------------------------------------------
let g:asyncrun_open = 8

" for python
function! s:async_black()
  execute 'AsyncRun black %'
endfunction
command! Black call s:async_black()

function! s:async_flake8()
  execute 'AsyncRun flake8 %'
endfunction
command! Flake8 call s:async_flake8()

function! s:async_pylint()
  execute 'AsyncRun pylint --disable=C,R,E1101 %'
endfunction
command! Pylint call s:async_pylint()

let g:ghost_darwin_app = 'iTerm2'
