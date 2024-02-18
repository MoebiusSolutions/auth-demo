#!/bin/bash

# Fail on any error or undefined variable
set -e -o pipefail -u

if [[ -f "${KEYCLOAK_PROVIDERS_DIR}/keycloak-protocol-cas.jar" ]]; then
    echo "Already downloaded [keycloak-protocol-cas]"
else
    echo "Downloading [keycloak-protocol-cas]"
    curl -sSfL -o "${KEYCLOAK_PROVIDERS_DIR}/keycloak-protocol-cas.jar" \
      "https://github.com/jacekkow/keycloak-protocol-cas/releases/download/${KEYCLOAK_VERSION}/keycloak-protocol-cas-${KEYCLOAK_VERSION}.jar"
fi

echo "[DONE] keycloak-init"