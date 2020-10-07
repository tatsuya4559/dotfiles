let s:lazy_load_plugins = []

augroup PackAutoCmd
  autocmd!
augroup END

function! s:add_package(repo, ...) abort
  let l:name = split(a:repo, '/')[1]
  let l:options = get(a:000, 0, {})

  " load for specific filetype
  if has_key(l:options, 'for')
    let l:filetypes = type(l:options['for']) == v:t_list ? join(l:options['for'], ',') : l:options['for']
    exe printf('autocmd PackAutoCmd FileType %s packadd %s', l:filetypes, l:name)
  endif

  " load on specific command
  if has_key(l:options, 'on')
    let l:cmd = type(l:options['on']) == v:t_list ? join(l:options['on'], ',') : l:options['on']
    exe printf('autocmd PackAutoCmd CmdUndefined %s packadd %s', l:cmd, l:name)
  endif

  " load after startup
  if has_key(l:options, 'lazy')
    if l:options['lazy']
      call add(s:lazy_load_plugins, l:name)
    endif
  endif

  if get(g:, 'loaded_minpac', v:false)
    call minpac#add(a:repo, l:options)
  endif
endfunction

command! -nargs=+ Pac call s:add_package(<args>)

function! PackAddHandler(timer) abort
  let l:plugin = remove(s:lazy_load_plugins, 0)
  exe 'packadd' l:plugin
  if empty(s:lazy_load_plugins)
    echo 'lazy load finished!'
  endif
endfunction

augroup LazyLoadBundle
  autocmd!
  autocmd VimEnter * call timer_start(10, 'PackAddHandler', {'repeat': len(s:lazy_load_plugins)})
augroup END

function! PackInit() abort
  if v:vim_did_enter
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
  endif

  " Syntax highlight
  Pac 'HerringtonDarkholme/yats.vim', {'type': 'opt', 'for': ['typescript', 'typescriptreact']}
  Pac 'MaxMEllon/vim-jsx-pretty', {'type': 'opt', 'for': ['javascript', 'javascriptreact', 'typescriptreact']}
  Pac 'evanleck/vim-svelte', {'branch': 'main'}

  " Colorscheme
  Pac 'arcticicestudio/nord-vim', {'type': 'opt'}
  Pac 'yasukotelin/shirotelin', {'type': 'opt'}

  " Text edit
  Pac 'haya14busa/vim-asterisk', {'type': 'opt', 'lazy': v:true}
  Pac 'justinmk/vim-sneak', {'type': 'opt', 'lazy': v:true}
  Pac 'machakann/vim-sandwich', {'type': 'opt', 'lazy': v:true}
  Pac 'markonm/traces.vim', {'type': 'opt', 'lazy': v:true}
  Pac 'thinca/vim-qfreplace', {'type': 'opt', 'for': 'qf'}
  Pac 'tpope/vim-commentary', {'type': 'opt', 'lazy': v:true}

  " File explore
  Pac 'ctrlpvim/ctrlp.vim'
  Pac 'tatsuya4559/filer.vim'

  " Language support
  Pac 'neoclide/coc.nvim', {'branch': 'release'}
  Pac 'pechorin/any-jump.vim', {'type': 'opt', 'lazy': v:true}
  Pac 'SirVer/ultisnips', {'type': 'opt', 'lazy': v:true}
  Pac 'AndrewRadev/tagalong.vim', {'type': 'opt', 'lazy': v:true}
  Pac 'mattn/emmet-vim', {'type': 'opt', 'lazy': v:true}
  Pac 'heavenshell/vim-pydocstring', {'type': 'opt', 'do': 'make install', 'for': 'python'}

  " Git
  Pac 'airblade/vim-gitgutter', {'type': 'opt', 'lazy': v:true}
  Pac 'ruanyl/vim-gh-line', {'type': 'opt', 'lazy': v:true}

  " Misc
  Pac 'AndrewRadev/linediff.vim', {'type': 'opt', 'on': 'Linediff'}
  Pac 'vim-jp/vimdoc-ja', {'type': 'opt', 'lazy': v:true}
endfunction

call PackInit()

command! -nargs=* PackUpdate source $MYVIMRC | call minpac#update([<f-args>])
command! -nargs=* PackClean source $MYVIMRC | call minpac#clean([<f-args>])
command! PackStatus call PackInit() | call minpac#status()
