#!/bin/bash

# Stop on any error
set -e -o pipefail

SCRIPT_FILE="$(basename "$0")"
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Log execution
set -x

ldapadd \
    -x -D 'cn=admin,dc=example,dc=com' -w 'password' \
    -H 'ldap://ldap:389' -f "${SCRIPT_DIR}/ldap-init.ldif"
