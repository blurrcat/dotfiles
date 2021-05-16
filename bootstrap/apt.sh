#!/usr/bin/env sh

set -ex
./common.sh

# add repo for rcm
sudo wget -q https://apt.thoughtbot.com/thoughtbot.gpg.key -O /etc/apt/trusted.gpg.d/thoughtbot.gpg
echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update

sudo apt-get install \
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

ln -s /usr/bin/batcat ~/bin/bat

rcup
