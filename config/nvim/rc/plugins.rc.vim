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
let g:fzf_preview_window = ''
nnoremap <silent> <C-p> :<C-u>GFiles<CR>
nnoremap <silent> <Space>c :<C-u>Commands<CR>
nnoremap <silent> <Space>l :<C-u>BLines<CR>
nnoremap <silent> <Space>L :<C-u>Lines<CR>
nnoremap <silent> <Space>f :<C-u>Rg<CR>
nnoremap <silent> <Space>h :<C-u>History<CR>
" }}}

" Coc {{{
let g:coc_global_extensions = [
            \   'coc-pairs',
            \   'coc-yank',
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
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)
nnoremap <silent> <Space>y  :<C-u>CocList -A --normal yank<CR>
nnoremap <silent> <Space>o  :<C-u>CocList outline<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" vmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
nnoremap <Leader>f :call <SID>format_document()<CR>
function! s:format_document()
    if &ft =~? 'javascript\|typescript'
        execute 'CocCommand prettier.formatFile'
    else
        call CocAction('format')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>ac  <Plug>(coc-codeaction)
" nmap <leader>qf  <Plug>(coc-fix-current)

inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

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
