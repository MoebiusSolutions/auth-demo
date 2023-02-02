#!/bin/bash

# Stop on error
set -e -o pipefail

# Install our root CA cert to the OS
cp /secrets/certs/ca-shared/root-ca.crt /usr/local/share/ca-certificates/
update-ca-certificates

# Launch the parent's entrypoint
/usr/local/bin/docker-entrypoint.sh "$@"