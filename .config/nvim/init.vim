set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

source ~/.vimrc

" neovim-only: native LSP client (lua/dry is linked into ~/.config/nvim by install.sh)
lua require('dry.lsp')
