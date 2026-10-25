" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

" packages {{{
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
"Plug 'honza/vim-snippets'
Plug 'sjbach/lusty'
Plug 'sjl/gundo.vim'
"Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'vim-scripts/indentpython.vim'
"Plug 'w0rp/ale'
"Plug 'tenable/vim-nasl'
"Plug 'Olical/conjure'
"Plug 'tpope/vim-dispatch'
" Only in Neovim:
"Plug 'radenling/vim-dispatch-neovim'
Plug 'bling/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/peaksea'
"Plug 'airblade/vim-gitgutter'
"Plug 'nvie/vim-flake8'
"Plug 'fisadev/vim-isort'
Plug 'NLKNguyen/papercolor-theme'
"Plug 'junegunn/seoul256.vim'
Plug 'jonathanfilip/vim-lucius'
"Plug 'editorconfig/editorconfig-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'main', 'do': ':TSUpdate'}
"Plug 'github/copilot.vim'
"Plug 'grafana/vim-alloy'
call plug#end()
" }}}
