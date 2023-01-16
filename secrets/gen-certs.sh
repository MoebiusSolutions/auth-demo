#!/bin/bash

# Stop on first error
set -e -o pipefail

SCRIPT_FILE="$(basename "$0")"
# NOTE: readlink will not work in OSX
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

function show_usage_and_exit() {
    echo "" >&2
    echo "Usage: $SCRIPT_FILE <target-directory>" >&2
    echo "" >&2
    exit 1
}

function generate_password() {
    set +e
    cat /dev/urandom | tr -dc 'A-Za-z0-9' | head -c 24
    set -e
}

function create_root_cert() {
    if [[ -f "${TARGET_DIR}/ca/root-ca.crt" ]]; then
        echo "[Root CA Cert Already Exists]"
    else
        echo "[Creating Root CA Cert]"
        openssl req -x509 -new -nodes -keyout "${TARGET_DIR}/ca/root-ca.key" -days 1024 -out "${TARGET_DIR}/ca/root-ca.crt" \
            -passin "pass:$ca_pass" \
            -subj "/C=US/ST=California/L=San Diego/O=DevOps/CN=Auth-Demo-RootCA"
    fi
}

function create_machine_cert() {
    local machine_fqdn="$1"
    shift

    if [[ -f "${TARGET_DIR}/${machine_fqdn}/cacerts.pem" ]]; then
        echo "[Machine cacerts Already Exists]: ${machine_fqdn}"
    else
        echo "[Creating cacerts]: ${machine_fqdn}"
        cp "${TARGET_DIR}/ca/root-ca.crt" "${TARGET_DIR}/${machine_fqdn}/cacerts.pem"
    fi

    if [[ -f "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.csr" ]]; then
        echo "[Machine CSR Already Exists]: ${machine_fqdn}"
    else
        echo "[Creating a Machine CSR and Key]: ${machine_fqdn}"
        # NOTE: "-nodes" prevents the need for a challenge password since we're doing this all locally
        openssl req -new -keyout "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.key" \
            -subj "/C=US/ST=California/L=San Diego/O=DevOps/CN=${machine_fqdn}" \
            -nodes  \
            -out "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.csr"
    fi

    if [[ -f "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.crt" ]]; then
        echo "[Machine Cert Already Exists]: ${machine_fqdn}"
    else
        echo "[Creating a Machine Cert]: ${machine_fqdn}"
        openssl x509 -req -in "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.csr" -CA "${TARGET_DIR}/ca/root-ca.crt" \
            -CAkey "${TARGET_DIR}/ca/root-ca.key" -passin "pass:$ca_pass" \
            -CAcreateserial -out "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.crt" -days 1024
    fi

    if [[ -f "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.crt-key.pem" ]]; then
        echo "[Machine Cert&Key Already Exists]: ${machine_fqdn}"
    else
        echo "[Creating a Machine Cert&Key]: ${machine_fqdn}"
        cat "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.crt" "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.key" \
            > "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.crt-key.pem"
    fi

    if [[ -f "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.p7b" ]]; then
        echo "[Machine pkcs7 File Already Exists]: ${machine_fqdn}"
    else
        echo "[Creating a Machine pkcs7 File]: ${machine_fqdn}"
        # NOTE: Java seems picky about the order of these certs, whereas Windows doesn't.
        openssl crl2pkcs7 -nocrl -certfile "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.crt" \
            -certfile "${TARGET_DIR}/ca/root-ca.crt" -out "${TARGET_DIR}/${machine_fqdn}/${machine_fqdn}.p7b"
    fi
}

if [[ $# != 1 ]]; then
    show_usage_and_exit
fi
TARGET_DIR="$1"

create_root_cert
create_machine_cert "*.auth-demo.docker"

echo "==== SUCCESS ===="