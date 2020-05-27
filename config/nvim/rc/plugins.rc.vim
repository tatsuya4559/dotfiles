" ultisnips {{{
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']
" }}}

" commentary {{{
nnoremap <Leader>\ :<C-u>Commentary<CR>
vnoremap <Leader>\ :Commentary<CR>
" }}}

" nerdtree {{{
nnoremap <silent> <Space>e :<C-u>NERDTreeToggle<CR>
nnoremap <silent> _ :<C-u>NERDTreeFind<CR>
let g:NERDTreeMapOpenVSplit = '<C-v>'
let g:NERDTreeMapOpenSplit = '<C-s>'
" }}}

" vaffle {{{
nnoremap <Space>v :<C-u>Vaffle<CR>
nnoremap <Leader>v :<C-u>Vaffle %:h<CR>
" }}}

" Tag bar {{{
nnoremap <Space>O :TagbarToggle<CR>
" }}}

" clap {{{
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
nnoremap <silent> <Space>f :Clap grep2<CR>
nnoremap <silent> <Space>y :Clap yanks<CR>
nnoremap <silent> <Space>h :Clap history<CR>
nnoremap <silent> <Space>r :Clap registers<CR>
nnoremap <silent> <Space>i :Clap filer<CR>

vnoremap <silent> <C-p> :Clap files ++query=@visual<CR>
vnoremap <silent> <Space>c :Clap command ++query=@visual<CR>
vnoremap <silent> <Space>b :Clap buffers ++query=@visual<CR>
vnoremap <silent> <Space>l :Clap blines ++query=@visual<CR>
vnoremap <silent> <Space>L :Clap lines ++query=@visual<CR>
vnoremap <silent> <Space>f :Clap grep2 ++query=@visual<CR>
" }}}

" Coc {{{
let g:coc_global_extensions = [
            \   'coc-pairs',
            \   'coc-snippets',
            \   'coc-prettier',
            \   'coc-html',
            \   'coc-css',
            \   'coc-tsserver',
            \   'coc-python',
            \   'coc-java',
            \   'coc-rls',
            \   'coc-json',
            \   'coc-yaml',
            \   'coc-vimlsp',
            \ ]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)
nnoremap <Leader>f :call <SID>format_document()<CR>
nnoremap <silent> <Space>o  :<C-u>CocList outline<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:format_document()
    if &ft =~? 'javascript\|typescript'
        execute 'CocCommand prettier.formatFile'
    else
        call CocAction('format')
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
" }}}

" Git {{{
nmap [git] <Nop>
map <Space>g [git]
nnoremap [git]s :<C-u>tab Gstatus<CR>
nnoremap [git]p :<C-u>call <SID>async_git_pull()<CR>
nnoremap [git]P :<C-u>call <SID>async_git_push()<CR>
nnoremap [git]d :<C-u>Gdiffsplit<CR>
nnoremap [git]b :<C-u>Gblame<CR>
nnoremap [git]w :<C-u>Gbrowse<CR>
vnoremap [git]w :Gbrowse<CR>

function! s:async_git_pull()
    execute 'AsyncRun git pull origin ' . fugitive#head()
endfunction

function! s:async_git_push()
    execute 'AsyncRun git push origin HEAD'
endfunction
" }}}

" emmet {{{
let g:user_emmet_mode='i'
let g:user_emmet_leader_key='<C-t>'
" }}}

" quickhl {{{
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
" }}}

" AnyJump {{{
let g:any_jump_disable_default_keybindings = 1
nnoremap <Space>j :AnyJump<CR>
xnoremap <Space>j :AnyJumpVisual<CR>
nnoremap <Space>al :AnyJumpLastResults<CR>
" }}}

" Async Run {{{
let g:asyncrun_open = 8
" }}}

" Python向けコマンド定義 {{{
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
" }}}
