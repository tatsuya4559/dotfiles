"================================================================================
" dein settings
"================================================================================
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    " 汎用プラグイン
    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('itchyny/lightline.vim')
    call dein#add('scrooloose/nerdtree')
    call dein#add('thinca/vim-quickrun')

    " git
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

    " 外観
    call dein#add('altercation/vim-colors-solarized')

    " テキスト操作系
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('tpope/vim-abolish')
    call dein#add('nelstrom/vim-visual-star-search')
    call dein#add('machakann/vim-sandwich')
    call dein#add('mattn/emmet-vim')

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif
" takes time; update manually
" if dein#check_update()
"     call dein#update()
" endif
call map(dein#check_clean(), "delete(v:val, 'rf')")
filetype plugin indent on
