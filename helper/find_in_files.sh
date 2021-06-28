#!/bin/bash

SEARCH_STRING="$1"

for file in **/*; do
	if grep -q "$SEARCH_STRING" "$file"; then
		echo "$file"
	fi
done
