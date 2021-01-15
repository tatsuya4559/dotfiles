let s:lazy_load_plugins = []

augroup PackAutoCmd
  autocmd!
augroup END

function! s:register_package(repo, ...) abort
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

  if exists('g:loaded_minpac')
    call minpac#add(a:repo, l:options)
  endif
endfunction

command! -nargs=+ Pack call s:register_package(<args>)

function! PackAddHandler(timer) abort
  let l:plugin = remove(s:lazy_load_plugins, 0)
  exe 'packadd' l:plugin
  if empty(s:lazy_load_plugins)
    echo 'lazy load finished!'
  endif
endfunction

augroup LazyLoad
  autocmd!
  autocmd VimEnter * call timer_start(10, 'PackAddHandler', {'repeat': len(s:lazy_load_plugins)})
augroup END

function! PackInit() abort
  if v:vim_did_enter
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
  endif

  " Colorscheme
  Pack 'arcticicestudio/nord-vim', {'type': 'opt'}
  Pack 'yasukotelin/shirotelin', {'type': 'opt'}
  Pack 'yasukotelin/notelight', {'type': 'opt'}

  " Text edit
  Pack 'haya14busa/vim-asterisk', {'type': 'opt', 'lazy': v:true}
  Pack 'machakann/vim-sandwich', {'type': 'opt', 'lazy': v:true}
  Pack 'markonm/traces.vim', {'type': 'opt', 'lazy': v:true}
  Pack 'thinca/vim-qfreplace', {'type': 'opt', 'lazy': v:false}
  Pack 'tpope/vim-commentary', {'type': 'opt', 'on': 'Commentary'}
  Pack 'cohama/lexima.vim', {'type': 'opt', 'lazy': v:false}

  " File explore
  Pack 'ctrlpvim/ctrlp.vim'
  Pack 'tatsuya4559/filer.vim'

  " Language support
  Pack 'neoclide/coc.nvim', {'branch': 'release', 'frozen': v:true}
  Pack 'pechorin/any-jump.vim', {'type': 'opt', 'on': ['AnyJump', 'AnyJumpVisual']}
  Pack 'SirVer/ultisnips', {'type': 'opt', 'lazy': v:true}
  Pack 'mattn/emmet-vim', {'type': 'opt', 'lazy': v:true}

  " Git
  Pack 'mhinz/vim-signify', {'type': 'opt', 'lazy': v:true}
  Pack 'ruanyl/vim-gh-line', {'type': 'opt', 'lazy': v:true}

  " Misc
  Pack 'AndrewRadev/linediff.vim', {'type': 'opt', 'on': 'Linediff'}
endfunction

call PackInit()

command! PackUpdate source $MYVIMRC | call minpac#update()
command! PackClean source $MYVIMRC | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
