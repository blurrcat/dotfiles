#!/usr/bin/env sh

set -ex
./common.sh

sudo apt-get install \
    bat \
    git \
    fish \
    tmux \
    mosh \
    vim \
    ripgrep \
    lynx \
    httpie

ln -s /usr/bin/batcat ~/bin/bat
