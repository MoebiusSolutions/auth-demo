#!/bin/bash

# Stop on error
set -e -o pipefail

echo "[ LDAP Admin Password ]"
echo "user: admin (cn=admin,dc=example,dc=com)"
echo "pass: $(cat /secrets/ldap/admin_password)"
echo ""

echo "[ LDAP PSwanson Password ]"
echo "user: pswanson (cn=Peter Swanson,ou=People,dc=example,dc=com)"
echo "pass: $(cat /secrets/ldap/pswanson_password)"
echo ""

echo "[ Keycloak Admin Password ]"
echo "user: $(cat /secrets/keycloak/admin_username)"
echo "pass: $(cat /secrets/keycloak/admin_password)"
echo ""
