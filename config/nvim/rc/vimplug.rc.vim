let s:vimplug_file = expand('~/.local/share/nvim/site/autoload/plug.vim')
if !filereadable(s:vimplug_file)
    execute 'silent !curl -fLo ' .
                \ s:vimplug_file .
                \ ' --create-dirs' .
                \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
else
    call plug#begin('~/.local/share/nvim/plugged')

    " Colorscheme
    Plug 'MaxMEllon/vim-jsx-pretty'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'evanleck/vim-svelte'
    Plug 'yasukotelin/shirotelin'
    Plug 'cocopon/iceberg.vim'

    " Text edit
    Plug 'bronson/vim-visual-star-search'
    Plug 'machakann/vim-sandwich'
    Plug 'mattn/emmet-vim'
    Plug 'tpope/vim-commentary'
    Plug 'terryma/vim-multiple-cursors'

    " File explore
    Plug 'liuchengxu/vim-clap', {'do': ':Clap install-binary'}
    Plug 'cocopon/vaffle.vim'

    " Language support
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'pechorin/any-jump.vim'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " Git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'

    " Utils
    Plug 'AndrewRadev/linediff.vim'
    Plug 'markonm/traces.vim'
    Plug 'tyru/capture.vim'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'vim-jp/vimdoc-ja'
    Plug 't9md/vim-quickhl'

    call plug#end()
endif
