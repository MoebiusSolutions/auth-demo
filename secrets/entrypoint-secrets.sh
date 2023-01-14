#!/bin/bash

# Stop on error
set -e -o pipefail

function generate_password() {
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

generate_password /secrets/ldap/admin_password
generate_password /secrets/ldap/pswanson_password

export LDAP_ADMIN_PASSWORD="$(cat /secrets/ldap/admin_password | tr -d '\n')"
export LDAP_PSWANSON_PASSWORD="$(cat /secrets/ldap/pswanson_password | tr -d '\n')"
export LDAP_PSWANSON_PASSWORD_ENCODED="$(slappasswd -n -T /secrets/ldap/pswanson_password)"

PW_FILE="/secrets/ldap/my-env.yaml"
echo "[ Generating ]: $PW_FILE" 1>&2
envsubst < /opt/ldap-init/my-env.yaml.bashtemplate > "$PW_FILE"
PW_FILE="/secrets/ldap/ldap-init.ldif"
echo "[ Generating ]: $PW_FILE" 1>&2
envsubst < /opt/ldap-init/ldap-init.ldif.bashtemplate > "$PW_FILE"

echo "[ SUCCESS (exiting) ]" 1>&2
