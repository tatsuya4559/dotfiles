" ultisnips {{{
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']
" }}}

" buftabline {{{
let g:buftabline_show=1
let g:buftabline_numbers=1
" }}}

" commentary {{{
nnoremap <Leader>\ :<C-u>Commentary<CR>
vnoremap <Leader>\ :Commentary<CR>
" }}}

" vaffle {{{
nnoremap <Space>v :<C-u>Vaffle<CR>
nnoremap <Space>n :<C-u>Vaffle %:h<CR>
" }}}

" NERDTree {{{
nnoremap <Space>e :<C-u>NERDTreeToggle<CR>
" }}}

" fzf {{{
nnoremap <silent> <C-p> :<C-u>GFiles<CR>
nnoremap <silent> <Space>c :<C-u>Commands<CR>
nnoremap <silent> <Space>l :<C-u>Blines<CR>
nnoremap <silent> <Space>L :<C-u>Lines<CR>
nnoremap <silent> <Space>f :<C-u>Rg<CR>
nnoremap <silent> <Space>h :<C-u>History<CR>
" }}}

" Coc {{{
let g:coc_global_extensions = [
            \   'coc-pairs',
            \   'coc-snippets',
            \   'coc-prettier',
            \   'coc-html',
            \   'coc-css',
            \   'coc-tailwindcss',
            \   'coc-tsserver',
            \   'coc-python',
            \   'coc-java',
            \   'coc-rls',
            \   'coc-vimlsp',
            \   'coc-json',
            \   'coc-yaml',
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
nnoremap [git]d :<C-u>Gdiffsplit<CR>
nnoremap [git]b :<C-u>Gblame<CR>
nnoremap [git]w :<C-u>Gbrowse<CR>
vnoremap [git]w :Gbrowse<CR>

let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '◾'
let g:gitgutter_sign_removed = '✖'
let g:gitgutter_sign_removed_first_line = '✖'
let g:gitgutter_sign_modified_removed = '✖'
" }}}

" emmet {{{
let g:user_emmet_mode='i'
let g:user_emmet_leader_key='<C-t>'
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
