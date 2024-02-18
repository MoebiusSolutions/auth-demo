#!/bin/bash

# Fail on error
set -e -o pipefail -u

# Annoyingly, Keycloak no longer supports KEYCLOAK_USER_FILE and KEYCLOAK_PASSWORD_FILE,
# so this wrapper script loads the values into variables
KEYCLOAK_ADMIN="$(cat /secrets/keycloak/admin_username)" 
export KEYCLOAK_ADMIN
KEYCLOAK_ADMIN_PASSWORD="$(cat "/secrets/keycloak/admin_password")"
export KEYCLOAK_ADMIN_PASSWORD

# Launch the original entrypoint
/opt/keycloak/bin/kc.sh start