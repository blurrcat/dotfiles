#!/usr/bin/env sh

set -ex

brew install \
    git \
    fish \
    tmux \
    mosh \
    vim \
    ripgrep \
    lynx \
    httpie

./common.sh
