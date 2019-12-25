#!/usr/bin/env sh

set -ex

sudo apt-get install \
    git \
    zsh \
    tmux \
    vim \
    ripgrep \
    httpie

mkdir -p ~/bin ~/lib
# antigen
curl -L git.io/antigen > ~/bin/antigen.zsh

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/lib/fzf
~/lib/fzf/install

./common.sh
