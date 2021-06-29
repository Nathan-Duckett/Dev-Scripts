#!/usr/bin/env bash
# Find in Files
# Usage: find_in_files.sh "$PATTERN"
# Description: Find any files which contain a pattern recursively through all subdirectories.

# Get the string pattern to be searched within the files.
SEARCH_STRING="$1"

# Recursive function definition to search through all the files within
search() {
  DIR_NAME="$1"
  for file in "$DIR_NAME"/*; do
    if [[ -d "$file" ]]; then
      search "$file"
      # Ensure to skip the search on directory
      continue
    fi
    if grep -q "$SEARCH_STRING" "$file"; then
      echo "$file"
    fi
  done
}

search .