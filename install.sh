#!/bin/sh

dotfiles_dir=$HOME/git/dotfiles

mkdir -p \
  $HOME/.config/nvim \
  $HOME/.config/pudb \
  $HOME/.config/alacritty \
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
ln -sf $dotfiles_dir/gpg.conf ${GNUPGHOME:-$HOME/.gnupg}/gpg.conf
ln -sf $dotfiles_dir/.config/alacritty/alacritty.toml $HOME/.config/alacritty/alacritty.toml

# Install vim-plug
if [ ! -f ~/.vim/autoload/plug.vim ]
then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
