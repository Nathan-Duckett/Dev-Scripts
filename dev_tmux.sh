#!/usr/bin/env bash

# Load ENV configuration into script during execution
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [[ -f "$SCRIPT_DIR/.env" ]]; then
    source "$SCRIPT_DIR/".env
fi

# Default git folders if not set for the search - only if not set in .env
if [[ -z "$git_folders" ]]; then
  git_folders="$HOME/Documents/"
fi

# Check for arguments if provided for a folder directory
if [[ $# -eq 1 ]]; then
    selected=$1
else
    items=""
    for name in "${git_folders[@]}"; do
        items+=$(find "$name" -maxdepth 1 -mindepth 1 -type d)
        # Add new line to ensure each repo is separate
        items+=$'\n'
    done
    selected=$(echo "$items" | fzf-tmux)
fi

# Check for early exit from fzf (if repo is blank)
if [[ -z "$selected" ]]; then
    exit 0
fi

# Get the name of the repo to name the tmux window
dirname=$(basename "$selected")

# Switch to the tmux session if it exists
if tmux switch-client -t "$dirname"; then
  exit 0
fi

# Create new session if it doesn't exist
tmux new-session -c "$selected" -d -s "$dirname" && (tmux switch-client -t "$dirname" || tmux new -c "$selected" -A -s "$dirname")
