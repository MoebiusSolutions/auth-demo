#!/bin/bash

# Fail on any error
set -e -o pipefail

SCRIPT_FILE="$(basename "$0")"
# NOTE: readlink will not work in OSX
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

bash "${SCRIPT_DIR}/authdemo-undeploy.sh"

sudo docker compose up --build -d
