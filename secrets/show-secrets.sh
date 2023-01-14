#!/bin/bash

# Stop on error
set -e -o pipefail

echo "[ LDAP Admin Password ]"
echo "$(cat /secrets/ldap/admin_password)"

echo "[ LDAP PSwanson Password ]"
echo "$(cat /secrets/ldap/pswanson_password)"
