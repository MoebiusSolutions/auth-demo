#!/bin/bash

# Stop on error
set -e -o pipefail

SCRIPT_FILE="$(basename "$0")"
# NOTE: readlink will not work in OSX
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

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

# Generates an password containing upper/lower/number/special chars
# (to meet complexity requirements).
function generate_complex_password() {
    PW_FILE="$1"
    shift

    if [[ -f "$PW_FILE" ]]; then
        echo "[ Password File Already Exists ]: $PW_FILE" 1>&2
        return
    fi
    echo "[ Generating Password ]: $PW_FILE" 1>&2
    set +e
    pwgen -cny 20 -1 | tr -d '\n' > "$PW_FILE"
    set -e
}

# Generates an alphanumeric password
# (which is generally perferred, because its the most compatible with automation).
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
    TARGET_VALUE="$1"
    shift
    TARGET_FILE="$1"
    shift

    echo "[ Writing Value ]: $TARGET_FILE" 1>&2
    echo -n "$TARGET_VALUE" > "$TARGET_FILE"
}

# Reads the first line, and triming any newline
function read_value() {
    TARGET_FILE="$1"
    shift

    echo "[ Reading ]: $TARGET_FILE" 1>&2
    head -n 1 "$TARGET_FILE" | tr -d '\n'
}

# Generate usernames/passwords
generate_password /secrets/ldap/admin_password
generate_password /secrets/ldap/pswanson_password
write_value "keycloak-admin" /secrets/keycloak/admin_username
generate_password /secrets/keycloak/admin_password
write_value "crowd-admin" /secrets/crowd/admin_username
generate_password /secrets/crowd/admin_password
write_value "bitbucket-admin" /secrets/bitbucket/admin_username
generate_password /secrets/bitbucket/admin_password
write_value "jira-admin" /secrets/jira/admin_username
generate_password /secrets/jira/admin_password
write_value "demo-bitbucket" /secrets/crowd-bitbucket/app_connector_name
generate_password /secrets/crowd-bitbucket/app_connector_password
write_value "ldap-bind" /secrets/ldap-bind/bind_username
generate_password /secrets/ldap-bind/bind_password
write_value "admin" /secrets/artifactory/admin_username
generate_complex_password /secrets/artifactory/admin_password

# Load variables used in template files
export LDAP_ADMIN_PASSWORD="$(read_value "/secrets/ldap/admin_password")"
export LDAP_PSWANSON_PASSWORD="$(read_value "/secrets/ldap/pswanson_password")"
export LDAP_READONLY_USER_USERNAME="$(read_value "/secrets/ldap-bind/bind_username")"
export LDAP_READONLY_USER_PASSWORD="$(read_value "/secrets/ldap-bind/bind_password")"
echo "[ Generating ]: LDAP_PSWANSON_PASSWORD_ENCODED" 1>&2
export LDAP_PSWANSON_PASSWORD_ENCODED="$(slappasswd -n -T /secrets/ldap/pswanson_password)"

# Render template files (using envsubst)
PW_FILE="/secrets/ldap/my-env.yaml"
echo "[ Generating ]: $PW_FILE" 1>&2
envsubst < /opt/ldap-init/my-env.yaml.bashtemplate > "$PW_FILE"
PW_FILE="/secrets/ldap/ldap-init.ldif"
echo "[ Generating ]: $PW_FILE" 1>&2
envsubst < /opt/ldap-init/ldap-init.ldif.bashtemplate > "$PW_FILE"

# Generate certificates
"$SCRIPT_DIR/gen-certs.sh" "/secrets/certs"

echo "[ SUCCESS (exiting) ]" 1>&2
