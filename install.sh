#!/bin/sh

dotfiles_dir=$HOME/git/dotfiles

mkdir -p \
  $HOME/.config/nvim \
  $HOME/.config/pudb \
  ${GNUPGHOME:-$HOME/.gnupg} \
  $HOME/.vim/scripts
ln -sf $dotfiles_dir/.zshrc $HOME/.zshrc
ln -sf $dotfiles_dir/.tmux.conf $HOME/.tmux.conf
ln -sf $dotfiles_dir/.gitconfig $HOME/.gitconfig
ln -sf $dotfiles_dir/.vim/rc $HOME/.vimrc
ln -sf $dotfiles_dir/.plsqlrc $HOME/.plsqlrc
ln -sf $dotfiles_dir/.vim/scripts/python.vim $HOME/.vim/scripts/python.vim
ln -sf $dotfiles_dir/.config/pudb/pudb.cfg $HOME/.config/pudb/pudb.cfg
ln -sf $dotfiles_dir/.config/nvim/init.vim $HOME/.config/nvim/init.vim
ln -sf $dotfiles_dir/.config/starship.toml $HOME/.config/starship.toml
