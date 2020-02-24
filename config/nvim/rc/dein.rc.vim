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

    " Colorscheme
    call dein#add('cocopon/iceberg.vim')
    call dein#add('MaxMEllon/vim-jsx-pretty')

    " Appearance
    call dein#add('itchyny/lightline.vim')

    " Text edit
    call dein#add('nelstrom/vim-visual-star-search')
    call dein#add('machakann/vim-sandwich')
    call dein#add('mattn/emmet-vim')
    call dein#add('tpope/vim-abolish')
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('tpope/vim-commentary')

    " File explore
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
    call dein#add('preservim/nerdtree')
    call dein#add('cocopon/vaffle.vim')

    " Language support
    call dein#add('neoclide/coc.nvim', { 'rev': 'release' })
    call dein#add('majutsushi/tagbar')
    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets')

    " Git
    call dein#add('airblade/vim-gitgutter')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-rhubarb')
    call dein#add('iberianpig/tig-explorer.vim', { 'depends': 'bclose.vim' })

    " Utils
    call dein#add('AndrewRadev/linediff.vim')
    call dein#add('osyo-manga/vim-anzu')
    call dein#add('tyru/capture.vim')
    call dein#add('skywind3000/asyncrun.vim')
    call dein#add('kana/vim-submode')
    call dein#add('rbgrouleff/bclose.vim')
    call dein#add('raghur/vim-ghost')

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
