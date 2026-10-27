" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

" packages {{{
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'rafamadriz/friendly-snippets'
Plug 'sjbach/lusty'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'jonathanfilip/vim-lucius'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'main', 'do': ':TSUpdate'}
call plug#end()
" }}}
