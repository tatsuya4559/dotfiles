setlocal nonumber
setlocal norelativenumber

nmap <buffer> s <C-w>
nmap <buffer><nowait> g <Plug>(fern-action-grep)
nmap <buffer><nowait> i <Plug>(fern-action-new-file)
nmap <buffer><nowait> o <Plug>(fern-action-new-dir)
nmap <buffer><nowait> c <Plug>(fern-action-copy)
nmap <buffer><nowait> m <Plug>(fern-action-move)
nmap <buffer><nowait> d <Plug>(fern-action-trash)
nmap <buffer><nowait> - <Plug>(fern-action-mark-toggle)
vmap <buffer><nowait> - <Plug>(fern-action-mark-toggle)
nmap <buffer><nowait> <C-m> <Plug>(fern-open-or-enter)
nmap <buffer><nowait> l <Plug>(fern-open-or-expand)
nmap <buffer><nowait> e <Plug>(fern-action-open:select)
nmap <buffer><nowait> <F5> <Plug>(fern-action-reload)
nmap <buffer><nowait> <C-h> <Plug>(fern-action-leave)
nmap <buffer><nowait> h <Plug>(fern-action-collapse)
nmap <buffer><nowait> !  <Plug>(fern-action-hidden-toggle)
nmap <buffer><nowait> fi <Plug>(fern-action-include)
nmap <buffer><nowait> fe <Plug>(fern-action-exclude)
nmap <buffer><nowait> <C-c> <Plug>(fern-action-cancel)
nmap <buffer><nowait> <C-l> <Plug>(fern-action-redraw)
nmap <buffer><nowait> r <Plug>(fern-action-rename)
nmap <buffer><nowait> C <Plug>(fern-action-clipboard-copy)
nmap <buffer><nowait> M <Plug>(fern-action-clipboard-move)
nmap <buffer><nowait> P <Plug>(fern-action-clipboard-paste)
