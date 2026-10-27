set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

source ~/.vimrc

" neovim-only: native LSP, snippet completion and treesitter highlighting
" (lua/dry is linked into ~/.config/nvim by install.sh)
lua require('dry.lsp')
lua require('dry.snippets')
lua require('dry.treesitter')
