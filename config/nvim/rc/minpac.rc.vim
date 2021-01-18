function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Colorscheme
  call minpac#add('arcticicestudio/nord-vim', {'type': 'opt'})
  call minpac#add('yasukotelin/shirotelin', {'type': 'opt'})
  call minpac#add('yasukotelin/notelight', {'type': 'opt'})

  " Text edit
  call minpac#add('haya14busa/vim-asterisk')
  call minpac#add('markonm/traces.vim')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('thinca/vim-qfreplace', {'type': 'opt'})
  call minpac#add('cohama/lexima.vim', {'type': 'opt'})

  " File explore
  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('tatsuya4559/filer.vim')

  " Language support
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
  call minpac#add('SirVer/ultisnips')
  call minpac#add('mattn/emmet-vim', {'type': 'opt'})

  " Git
  call minpac#add('ruanyl/vim-gh-line', {'type': 'opt'})
endfunction

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
