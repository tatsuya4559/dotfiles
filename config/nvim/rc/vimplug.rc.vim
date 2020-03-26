let s:vimplug_file = has('nvim')
            \ ? expand('~/.local/share/nvim/site/autoload/plug.vim')
            \ : expand('~/.vim/autoload/plug.vim')
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
    Plug 'yasukotelin/shirotelin'
    Plug 'cocopon/iceberg.vim'

    " Text edit
    Plug 'nelstrom/vim-visual-star-search'
    Plug 'machakann/vim-sandwich'
    Plug 'mattn/emmet-vim'
    Plug 'tpope/vim-commentary'

    " File explore
    if has('nvim-0.4.2') || has('patch-8.1.2114')
        Plug 'liuchengxu/vim-clap', {'do': ':Clap install-binary'}
    endif
    Plug 'preservim/nerdtree'

    " Language support
    if executable('node')
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
    endif
    if executable('rg') && (has('nvim-0.4') || has('vim-8.2'))
        Plug 'pechorin/any-jump.vim'
    endif
    Plug 'majutsushi/tagbar'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

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
    Plug 't9md/vim-quickhl'

    call plug#end()
endif
