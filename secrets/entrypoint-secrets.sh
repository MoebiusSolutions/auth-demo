#!/bin/bash

# Stop on error
set -e -o pipefail

function generate_memorable_password() {
    PW_FILE="$1"
    shift

    if [[ -f "$PW_FILE" ]]; then
        echo "[ Password File Already Exists ]: $PW_FILE" 1>&2
        return
    fi
    echo "[ Generating Password ]: $PW_FILE" 1>&2
    cat /opt/secrets/words_3000.txt \
        `# filter out special char words` \
        | grep -P '^[a-zA-Z]+$' \
        `# filter out short words` \
        | grep -P '^.....' \
        `# to lower case` \
        | tr '[:upper:]' '[:lower:]' \
        `# select random words` \
        | shuf -n 5 \
        `# concatonate with dashes` \
        | tr "\n" "-" \
        > "$PW_FILE"
    # append number
    echo -n "$(shuf -i0-999 -n 1)" \
        >> "$PW_FILE"
}

function generate_password() {
    PW_FILE="$1"
    shift

    if [[ -f "$PW_FILE" ]]; then
        echo "[ Password File Already Exists ]: $PW_FILE" 1>&2
        return
    fi
    echo "[ Generating Password ]: $PW_FILE" 1>&2
    set +e
    cat /dev/urandom | tr -dc 'A-Za-z0-9' | head -c 24 > "$PW_FILE"
    set -e
}

function write_value() {
    TARGET_FILE="$1"
    shift

    echo "[ Writing Value ]: $TARGET_FILE" 1>&2
    echo -n "$1" > "$TARGET_FILE"
}

generate_password /secrets/ldap/admin_password
generate_password /secrets/ldap/pswanson_password
write_value "keycloak-admin" /secrets/keycloak/admin_username
generate_password /secrets/keycloak/admin_password
write_value "crowd-admin" /secrets/crowd/admin_username
generate_password /secrets/crowd/admin_password
write_value "bitbucket-admin" /secrets/bitbucket/admin_username
generate_password /secrets/bitbucket/admin_password
write_value "demo-bitbucket" /secrets/crowd-bitbucket/app_connector_name
generate_password /secrets/crowd-bitbucket/app_connector_password

echo "[ Reading ]: /secrets/ldap/admin_password" 1>&2
export LDAP_ADMIN_PASSWORD="$(cat /secrets/ldap/admin_password | tr -d '\n')"
echo "[ Reading ]: /secrets/ldap/pswanson_password" 1>&2
export LDAP_PSWANSON_PASSWORD="$(cat /secrets/ldap/pswanson_password | tr -d '\n')"
echo "[ Generating ]: LDAP_PSWANSON_PASSWORD_ENCODED" 1>&2
export LDAP_PSWANSON_PASSWORD_ENCODED="$(slappasswd -n -T /secrets/ldap/pswanson_password)"

PW_FILE="/secrets/ldap/my-env.yaml"
echo "[ Generating ]: $PW_FILE" 1>&2
envsubst < /opt/ldap-init/my-env.yaml.bashtemplate > "$PW_FILE"
PW_FILE="/secrets/ldap/ldap-init.ldif"
echo "[ Generating ]: $PW_FILE" 1>&2
envsubst < /opt/ldap-init/ldap-init.ldif.bashtemplate > "$PW_FILE"

echo "[ SUCCESS (exiting) ]" 1>&2
