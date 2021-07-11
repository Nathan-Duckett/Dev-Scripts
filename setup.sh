#!/usr/bin/env bash
set -x
# Load ENV configuration into script during execution
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [[ -f "$SCRIPT_DIR/.env" ]]; then
    source "$SCRIPT_DIR/".env
fi

# Default dev_scripts home if not set in env
if [[ -z "$dev_scripts_location" ]]; then
  $dev_scripts_location="$HOME/Documents/github_repos/Dev-Scripts"
fi

# Generate the command to set the DEV_SCRIPTS_HOME folder
FOLDER_PATH_COMMAND="export DEV_SCRIPTS_HOME=\"$dev_scripts_location\""

# Target profile file e.g. bashrc or bash_profile
if [[ "$SHELL" == "fish" ]]; then
  TARGET_PROFILE="$HOME/.config/fish/config.fish"
elif [[ "$SHELL" == "/usr/bin/zsh" ]]; then
  TARGET_PROFILE="$HOME/.zshrc"
else
  TARGET_PROFILE="$HOME/.bashrc"
fi

# Check if content exists for Dev-Scripts path and set in bashrc
if ! grep "$FOLDER_PATH_COMMAND" "$TARGET_PROFILE"; then
  echo "$FOLDER_PATH_COMMAND" >> "$TARGET_PROFILE"
fi

# Check if content exists for sourced aliases in bashrc
if ! grep "source $dev_scripts_location/aliases" "$TARGET_PROFILE"; then
  echo "source $dev_scripts_location/aliases" >> "$TARGET_PROFILE"
fi
