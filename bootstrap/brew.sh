#!/usr/bin/env sh

set -ex

brew install \
    git \
    zsh \
    antigen \
    tmux \
    vim \
    ripgrep \
    httpie \
    fzf

./common.sh
