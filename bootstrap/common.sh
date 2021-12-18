#!/usr/bin/env sh
set -ex

mkdir -p ~/bin ~/lib

# TPM
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

rcup

chsh -s `which fish`
echo "Changed your default shell to fish!"
