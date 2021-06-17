#!/usr/bin/env bash

# Job name to retrieve details from Jenkins
JOB_NAME="$1"

# Execution ID of the pipeline
EXECUTION_ID="$2"

# Load ENV configuration into script during execution
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [[ -f "$SCRIPT_DIR/.env" ]]; then
    source "$SCRIPT_DIR/".env
fi

# Remove any spaces in JOB_NAME
JOB_NAME="$(echo "$JOB_NAME" | sed 's/ /%20/g')"

curl -kq "$JENKINS_URL/job/$JOB_NAME/$EXECUTION_ID/consoleText" | less