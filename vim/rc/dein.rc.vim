"================================================================================
" dein settings
"================================================================================
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#add(s:dein_repo_dir)
    " Plugin manager
    "call dein#add('Shougo/dein.vim')

    " Appearance
    call dein#add('altercation/vim-colors-solarized')
    call dein#add('joshdick/onedark.vim')
    call dein#add('itchyny/lightline.vim')
    call dein#add('Yggdroot/indentLine')
    call dein#add('majutsushi/tagbar')

    " Text edit
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('tpope/vim-abolish')
    call dein#add('nelstrom/vim-visual-star-search')
    call dein#add('machakann/vim-sandwich')
    call dein#add('mattn/emmet-vim')

    " File explore
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
    call dein#add('scrooloose/nerdtree')

    " Completion
    call dein#add('Shougo/deoplete.nvim')

    " Linter
    call dein#add('dense-analysis/ale')

    call dein#add('thinca/vim-quickrun')

    " git
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

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
