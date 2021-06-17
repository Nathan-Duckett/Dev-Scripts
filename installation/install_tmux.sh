#!/usr/bin/env bash

TMUX_VERSION="3.2"

wget https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz

tar -xvf tmux-$TMUX_VERSION.tar.gz

# Exit with code 100 if directory doesn't exist
cd tmux-$TMUX_VERSION/ || exit 100

./configure && make

sudo make install