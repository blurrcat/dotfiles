#!/usr/bin/env sh

set -ex

brew install \
    git \
    fish \
    tmux \
    vim \
    ripgrep \
    httpie

./common.sh
