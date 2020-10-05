call plug#begin('~/.local/share/nvim/plugged')

" Syntax highlight
Plug 'HerringtonDarkholme/yats.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

" Colorscheme
Plug 'arcticicestudio/nord-vim'
Plug 'yasukotelin/shirotelin'

" Text edit
Plug 'haya14busa/vim-asterisk'
Plug 'justinmk/vim-sneak'
Plug 'machakann/vim-sandwich'
Plug 'thinca/vim-qfreplace'
Plug 'tpope/vim-commentary'

" File explore
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tatsuya4559/filer.vim'

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pechorin/any-jump.vim' " cocでジャンプできないpythonのため
Plug 'SirVer/ultisnips'
Plug 'AndrewRadev/tagalong.vim'
Plug 'mattn/emmet-vim'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

" Git
Plug 'airblade/vim-gitgutter'
Plug 'ruanyl/vim-gh-line'

" Utils
Plug 'AndrewRadev/linediff.vim'
Plug 'vim-jp/vimdoc-ja'

call plug#end()
