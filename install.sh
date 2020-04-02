#!/bin/sh

self=`realpath $0`
dotfiles_dir=`dirname $self`

mkdir -p \
  $HOME/.config/nvim \
  $HOME/.config/pudb \
  $HOME/.vim/scripts
ln -s $dotfiles_dir/.zshrc $HOME/.zshrc
ln -s $dotfiles_dir/.tmux.conf $HOME/.tmux.conf
ln -s $dotfiles_dir/.gitconfig $HOME/.gitconfig
ln -s $dotfiles_dir/.vim/rc $HOME/.vimrc
ln -s $dotfiles_dir/.vim/scripts/python.vim $HOME/.vim/scripts/python.vim
ln -s $dotfiles_dir/.config/pudb/pudb.cfg $HOME/.config/pudb/pudb.cfg
ln -s $dotfiles_dir/.config/nvim/init.vim $HOME/.config/nvim/init.vim
