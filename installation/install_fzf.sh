#!/usr/bin/env bash

INSTALLATION_LOCATION="/opt/fzf"

git clone --depth 1 https://github.com/junegunn/fzf.git "$INSTALLATION_LOCATION/fzf"
"$INSTALLATION_LOCATION"/fzf/install --all