#!/usr/bin/env sh

set -ex

sudo apt-get install \
    git \
    zsh \
    zsh-antigen \
    tmux \
    vim \
    ripgrep \
    httpie \
    fzf

./common.sh
