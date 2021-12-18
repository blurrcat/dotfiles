#!/usr/bin/env sh

set -ex

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

./common.sh
