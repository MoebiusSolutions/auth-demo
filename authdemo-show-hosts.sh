#!/bin/bash

# Fail on any error
set -e -o pipefail

SCRIPT_FILE="$(basename "$0")"
# NOTE: readlink will not work in OSX
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

. "$SCRIPT_DIR/.env"

echo ""
echo "# ==== BEGIN: auth-demo hosts ===="
echo "${ENV_IP_PREFIX}.6 secrets.${ENV_DOMAIN}"
echo -n "${ENV_IP_PREFIX}.8 proxy.${ENV_DOMAIN}"
echo -n " ldap-ui.proxy.${ENV_DOMAIN}"
echo -n " keycloak.proxy.${ENV_DOMAIN}"
echo -n " crowd.proxy.${ENV_DOMAIN}"
echo -n " bitbucket.proxy.${ENV_DOMAIN}"
echo -n " jira.proxy.${ENV_DOMAIN}"
echo -n " artifactory.proxy.${ENV_DOMAIN}"
echo ""
echo "${ENV_IP_PREFIX}.2 ldap.${ENV_DOMAIN}"
echo "${ENV_IP_PREFIX}.5 ldap-ui.${ENV_DOMAIN}"
echo "${ENV_IP_PREFIX}.7 keycloak.${ENV_DOMAIN}"
echo "${ENV_IP_PREFIX}.4 crowd.${ENV_DOMAIN}"
echo "${ENV_IP_PREFIX}.3 bitbucket.${ENV_DOMAIN}"
echo "${ENV_IP_PREFIX}.9 jira.${ENV_DOMAIN}"
echo "${ENV_IP_PREFIX}.10 artifactory.${ENV_DOMAIN}"
echo "# ==== END: auth-demo hosts ===="
echo ""
