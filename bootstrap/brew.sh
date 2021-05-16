#!/usr/bin/env sh

set -ex

./common.sh

brew install \
    bat \
    git \
    fish \
    tmux \
    mosh \
    vim \
    rcm \
    ripgrep \
    lynx \
    httpie

rcup
