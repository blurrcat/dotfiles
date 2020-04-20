#!/usr/bin/env sh

set -ex

sudo apt-get install \
    bat \
    git \
    fish \
    tmux \
    mosh \
    vim \
    ripgrep \
    httpie

mkdir -p ~/bin ~/lib
./common.sh
