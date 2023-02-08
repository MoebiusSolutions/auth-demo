#!/bin/bash

# Fail on any error
set -e -o pipefail

SCRIPT_FILE="$(basename "$0")"
# NOTE: readlink will not work in OSX
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

. "$SCRIPT_DIR/.env"

echo ""
echo "# ==== BEGIN: auth-demo hosts ===="
echo "${ENV_IP_PREFIX}.6 secrets.auth-demo.docker"
echo -n "${ENV_IP_PREFIX}.8 proxy.auth-demo.docker"
echo -n " ldap-ui.proxy.auth-demo.docker"
echo -n " keycloak.proxy.auth-demo.docker"
echo -n " crowd.proxy.auth-demo.docker"
echo -n " bitbucket.proxy.auth-demo.docker"
echo -n " jira.proxy.auth-demo.docker"
echo -n " artifactory.proxy.auth-demo.docker"
echo ""
echo "${ENV_IP_PREFIX}.2 ldap.auth-demo.docker"
echo "${ENV_IP_PREFIX}.5 ldap-ui.auth-demo.docker"
echo "${ENV_IP_PREFIX}.7 keycloak.auth-demo.docker"
echo "${ENV_IP_PREFIX}.4 crowd.auth-demo.docker"
echo "${ENV_IP_PREFIX}.3 bitbucket.auth-demo.docker"
echo "${ENV_IP_PREFIX}.9 jira.auth-demo.docker"
echo "${ENV_IP_PREFIX}.10 artifactory.auth-demo.docker"
echo "# ==== END: auth-demo hosts ===="
echo ""
