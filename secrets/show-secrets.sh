#!/bin/bash

# Stop on error
set -e -o pipefail

echo "[ LDAP Admin ]"
echo "user: admin (cn=admin,dc=example,dc=com)"
echo "pass: $(cat /secrets/ldap/admin_password)"
echo ""

echo "[ LDAP Bind (read-only) ]"
echo "user: $(cat /secrets/ldap-bind/bind_username) (cn=$(cat /secrets/ldap-bind/bind_username),dc=example,dc=com)"
echo "pass: $(cat /secrets/ldap-bind/bind_password)"
echo ""

echo "[ LDAP User: Peter Swanson ]"
echo "user: pswanson (cn=Peter Swanson,ou=People,dc=example,dc=com)"
echo "pass: $(cat /secrets/ldap/pswanson_password)"
echo ""

echo "[ Keycloak Admin ]"
echo "user: $(cat /secrets/keycloak/admin_username)"
echo "pass: $(cat /secrets/keycloak/admin_password)"
echo ""

echo "[ Crowd Admin ]"
echo "user: $(cat /secrets/crowd/admin_username)"
echo "pass: $(cat /secrets/crowd/admin_password)"
echo ""

echo "[ Bitbucket Admin ]"
echo "user: $(cat /secrets/bitbucket/admin_username)"
echo "pass: $(cat /secrets/bitbucket/admin_password)"
echo ""

echo "[ Crowd/Bitbucket App Connector ]"
echo "name: $(cat /secrets/crowd-bitbucket/app_connector_name)"
echo "pass: $(cat /secrets/crowd-bitbucket/app_connector_password)"
echo ""
