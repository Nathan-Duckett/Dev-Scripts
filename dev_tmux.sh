#!/usr/bin/env bash

# Load ENV configuration into script during execution
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [[ -f "$SCRIPT_DIR/.env" ]]; then
    source "$SCRIPT_DIR/".env
fi

# Chcek for arguments if provided for a folder directory
if [[ $# -eq 1 ]]; then
    selected=$1
else
    items=""
    for name in ${git_folders[@]}; do
        items+=$(find "$name" -maxdepth 1 -mindepth 1 -type d)
        # Add new line to ensure each repo is separate
        items+='\n'
    done
    selected=$(echo "$items" | fzf-tmux)
fi

# Get the name of the repo to name the tmux window
dirname=$(basename "$selected")

# Switch to the tmux session if it exists
tmux switch-client -t $dirname
if [[ $? -eq 0 ]]; then
    exit 0
fi

# Create new session if it doesn't exist
tmux new-session -c "$selected" -d -s "$dirname" && tmux switch-client -t "$dirname" || tmux new -c "$selected" -A -s "$dirname"
