#!/bin/bash

# Stop on error
set -e -o pipefail

SCRIPT_FILE="$(basename "$0")"

function show_usage_and_exit() {
    echo "" >&2
    echo "USAGE: $SCRIPT_FILE <contianer-name>" >&2
    echo "" >&2
    exit 1
}

if [[ $# != 1 ]]; then
    show_usage_and_exit
fi

sudo docker compose stop "$1" && sudo docker compose rm "$1" --force 

echo "[[ SUCCESS ]]"
