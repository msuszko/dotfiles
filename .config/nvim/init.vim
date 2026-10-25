set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

source ~/.vimrc

" neovim-only: native LSP and treesitter highlighting
" (lua/dry is linked into ~/.config/nvim by install.sh)
lua require('dry.lsp')
lua require('dry.treesitter')
