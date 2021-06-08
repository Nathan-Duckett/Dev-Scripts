#!/usr/bin/env bash

TMUX_VERSION="3.2"

wget https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz

tar -xvf tmux-$TMUX_VERSION.tar.gz

cd tmux-$TMUX_VERSION/

./configure && make

sudo make install