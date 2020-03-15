"================================================================================
" plugin settings
"================================================================================
" ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']

" commentary --------------------------------------------------------------------
nnoremap <Leader>\ :<C-u>Commentary<CR>
vnoremap <Leader>\ :Commentary<CR>

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

" Tag bar ----------------------------------------------------------------------
nnoremap <Space>O :TagbarToggle<CR>

" clap --------------------------------------------------------------------------
let g:clap_layout = {
  \ 'relative': 'editor',
  \ 'width': '67%',
  \ 'height': '33%',
  \ 'row': '10%',
  \ 'col': '17%'
  \}
let g:clap_insert_mode_only = 1
nnoremap <silent> <C-p> :Clap files<CR>
nnoremap <silent> <Space>c :Clap command<CR>
nnoremap <silent> <Space>b :Clap buffers<CR>
nnoremap <silent> <Space>l :Clap blines<CR>
nnoremap <silent> <Space>L :Clap lines<CR>
nnoremap <silent> <Space>g :Clap grep<CR>
nnoremap <silent> <Space>y :Clap yanks<CR>
nnoremap <silent> <Space>h :Clap history<CR>
nnoremap <silent> <Space>r :Clap registers<CR>
nnoremap <silent> <Space>f :Clap filer<CR>

vnoremap <silent> <C-p> :Clap files ++query=@visual<CR>
vnoremap <silent> <Space>c :Clap command ++query=@visual<CR>
vnoremap <silent> <Space>b :Clap buffers ++query=@visual<CR>
vnoremap <silent> <Space>l :Clap blines ++query=@visual<CR>
vnoremap <silent> <Space>L :Clap lines ++query=@visual<CR>
vnoremap <silent> <Space>g :Clap grep ++query=@visual<CR>

" Coc ---------------------------------------------------------------------------
let g:coc_global_extensions = [
  \   'coc-pairs',
  \   'coc-snippets',
  \   'coc-prettier',
  \   'coc-html',
  \   'coc-css',
  \   'coc-tsserver',
  \   'coc-python',
  \   'coc-java',
  \   'coc-json',
  \   'coc-yaml',
  \ ]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)
nnoremap <Leader>f :call <SID>format_document()<CR>
nnoremap <silent> <Space>o  :<C-u>CocList outline<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <Space>t  :<C-u>CocList -I symbols<CR>

function! s:format_document()
  if &ft =~? 'javascript\|typescript'
    execute 'CocCommand prettier.formatFile'
  elseif &ft =~? 'python'
    " TODO: blackのフォーマットができるようにする
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
map <Leader>g [git]
nnoremap [git]s :<C-u>TigStatus<CR>
nnoremap [git]p :<C-u>call <SID>async_git_pull()<CR>
nnoremap [git]P :<C-u>call <SID>async_git_push()<CR>
nnoremap [git]d :<C-u>Gina compare<CR>
nnoremap [git]b :<C-u>Gblame<CR>
nnoremap [git]w :<C-u>Gbrowse<CR>
vnoremap [git]w :Gbrowse<CR>

function! s:async_git_pull()
  execute 'AsyncRun git pull origin ' . fugitive#head()
endfunction

function! s:async_git_push()
  execute 'AsyncRun git push origin HEAD'
endfunction

" Gina --------------------------------------------------------------------------
call gina#custom#action#alias(
  \ '/.*', 'dp', 'diff:preview:top'
  \)

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
