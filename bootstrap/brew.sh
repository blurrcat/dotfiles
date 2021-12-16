#!/usr/bin/env sh

set -ex

./common.sh

brew install \
    alacritty \
    bat \
    git \
    fish \
    tmux \
    mosh \
    neovim \
    rcm \
    ripgrep \
    lynx \
    httpie

rcup
