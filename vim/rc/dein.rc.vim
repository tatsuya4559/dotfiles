"================================================================================
" dein settings
"================================================================================
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath+=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#add(s:dein_repo_dir)

    " Appearance
    call dein#add('morhetz/gruvbox')
    call dein#add('joshdick/onedark.vim')
    call dein#add('itchyny/lightline.vim')
    call dein#add('majutsushi/tagbar')

    " Text edit
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('tpope/vim-abolish')
    call dein#add('nelstrom/vim-visual-star-search')
    call dein#add('machakann/vim-sandwich')
    call dein#add('mattn/emmet-vim')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('terryma/vim-expand-region')

    " File explore
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
    call dein#add('scrooloose/nerdtree')
    call dein#add('iberianpig/ranger-explorer.vim')

    " LSP
    call dein#add('neoclide/coc.nvim', {'branch': 'release'})

    " Snippets
    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets')

    " Git
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('iberianpig/tig-explorer.vim') "日本語表示に不具合あり。tig使うほうがいいかも
    call dein#add('rbgrouleff/bclose.vim') "for tig-explore

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
