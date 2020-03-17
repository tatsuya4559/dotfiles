let s:vimplug_file = expand('~/.local/share/nvim/site/autoload/plug.vim')
if !filereadable(s:vimplug_file)
    execute 'curl -fLo ' .
                \ s:vimplug_file .
                \ ' --create-dirs' .
                \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
    call plug#begin('~/.local/share/nvim/plugged')

    " Colorscheme
    Plug 'MaxMEllon/vim-jsx-pretty'
    Plug 'yasukotelin/shirotelin'
    Plug 'cocopon/iceberg.vim'

    " Text edit
    Plug 'nelstrom/vim-visual-star-search'
    Plug 'machakann/vim-sandwich'
    Plug 'mattn/emmet-vim'
    Plug 'tpope/vim-commentary'

    " File explore
    Plug 'liuchengxu/vim-clap', {'do': ':Clap install-binary'}
    Plug 'preservim/nerdtree'

    " Language support
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'majutsushi/tagbar'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'pechorin/any-jump.vim'

    " Git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'

    " Utils
    Plug 'AndrewRadev/linediff.vim'
    Plug 'osyo-manga/vim-anzu'
    Plug 'tyru/capture.vim'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'kana/vim-submode'
    Plug 'vim-jp/vimdoc-ja'

    call plug#end()
endif
