#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [[ -f "$SCRIPT_DIR/.env" ]]; then
    source "$SCRIPT_DIR/".env
fi

if [[ $# -eq 1 ]]; then
    selected=$1
else
    items=""
    for name in ${git_folders[@]}; do
        items+=$(find "$name" -maxdepth 1 -mindepth 1 -type d)
    done
    selected=`echo "$items" | fzf-tmux`
fi

dirname=`basename $selected`

tmux switch-client -t $dirname
if [[ $? -eq 0 ]]; then
    exit 0
fi

tmux new-session -c $selected -d -s $dirname && tmux switch-client -t $dirname || tmux new -c $selected -A -s $dirname
