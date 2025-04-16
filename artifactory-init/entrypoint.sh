#!/bin/bash

set -e -o pipefail -u

# Standard initialization (https://jfrog.com/help/r/jfrog-installation-setup-documentation/install-artifactory-single-node-with-docker)
JFROG_HOME="/var/opt/jfrog/artifactory"
mkdir -p "$JFROG_HOME/etc"
touch "$JFROG_HOME/etc/system.yaml"
# We are already the taret user
#chown -R 1030:1030 "$JFROG_HOME/var"

# Inject database config
cat << EOF > "$JFROG_HOME/etc/system.yaml"
shared:
  database:
    driver: org.postgresql.Driver
    type: postgresql
    url: jdbc:postgresql://artifactory-postgres:5432/artifactory
    username: artifactory
    password: $(cat /secrets/artifactory-postgres/admin_password)
EOF
