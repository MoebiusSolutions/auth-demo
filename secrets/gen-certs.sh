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
    local target_dir_ca="$1"
    shift

    if [[ -f "${target_dir_ca}/root-ca.crt" ]]; then
        echo "[Root CA Cert Already Exists]"
    else
        echo "[Creating Root CA Cert]"
        # NOTE: Using a config file in order to specify KeyUsage:CertificateSign
        #       (required by some software, such as MITMProxy)
        cat << EOF > "${target_dir_ca}/root-ca.req.config"
[req]
default_bits = 2048
distinguished_name = req_distinguished_name
x509_extensions  = req_x509_ext
prompt = no

[req_distinguished_name]
C = US
ST = California
L = San Diego
O = Auth-Demo
OU = Auth-Demo
CN = Auth-Demo-RootCA

[req_x509_ext]
basicConstraints       = critical, CA:true
#subjectKeyIdentifier   = hash
#authorityKeyIdentifier = keyid:always, issuer:always
keyUsage               = cRLSign, keyCertSign
#extendedKeyUsage       = codeSigning, timeStamping
#subjectAltName         = DNS:ca.fyicenter.com, email:ca@fyicenter.com
#issuerAltName          = issuer:copy
EOF
        openssl req -x509 -new -nodes \
            -keyout "${target_dir_ca}/root-ca.crt.key" \
            -days 1024 \
            -out "${target_dir_ca}/root-ca.crt" \
            -config "${target_dir_ca}/root-ca.req.config"
    fi
}

function create_machine_cert() {
    local target_dir_ca="$1"
    shift
    local target_dir_machine="$1"
    shift
    local machine_fqdn="$1"
    shift

    if [[ -f "${target_dir_machine}/${machine_fqdn}.crt.key" ]]; then
        echo "[Machine CSR and Key Already Exists]: ${machine_fqdn}"
    else
        echo "[Creating a Machine CSR and Key]: ${machine_fqdn}"
        # NOTE: Using a config file in order to specify SubjectAltName (now required by browsers)
        cat << EOF > "${target_dir_machine}/${machine_fqdn}.req.config"
[req]
default_bits = 2048
distinguished_name = req_distinguished_name
req_extensions = req_ext
prompt = no

[req_distinguished_name]
C = US
ST = California
L = San Diego
O = Auth-Demo
OU = Auth-Demo
CN = ${machine_fqdn}

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${machine_fqdn}
#DNS.2 = other.hostname
#IP.1 = 192.168.1.1
#IP.2 = 192.168.1.2
EOF
        openssl req -new -nodes \
            -keyout "${target_dir_machine}/${machine_fqdn}.crt.key" \
            -out "${target_dir_machine}/${machine_fqdn}.csr" \
            -config "${target_dir_machine}/${machine_fqdn}.req.config"
    fi

    if [[ -f "${target_dir_machine}/${machine_fqdn}.crt" ]]; then
        echo "[Machine Cert Already Exists]: ${machine_fqdn}"
    else
        echo "[Creating a Machine Cert]: ${machine_fqdn}"
        openssl x509 -req -days 1024 \
            `# Trust and include all extensions in the CSR` \
            -copy_extensions copyall \
            -in "${target_dir_machine}/${machine_fqdn}.csr" \
            -CA "${target_dir_ca}/root-ca.crt" \
            -CAkey "${target_dir_ca}/root-ca.crt.key" \
            -CAcreateserial \
            -out "${target_dir_machine}/${machine_fqdn}.crt" 
    fi

    # Create folder for HAProxy-specific files
    mkdir -p "${target_dir_machine}/haproxy"

    # Generate cert+key file in the format expected by HAProxy
    if [[ -f "${target_dir_machine}/haproxy/${machine_fqdn}.pem" ]]; then
        echo "[Machine HAProxy Cert Already Exists]: ${machine_fqdn}"
    else
        echo "[Creating a Machine HAProxy Cert]: ${machine_fqdn}"
        cat "${target_dir_machine}/${machine_fqdn}.crt" "${target_dir_ca}/root-ca.crt" "${target_dir_machine}/${machine_fqdn}.crt.key" \
            > "${target_dir_machine}/haproxy/${machine_fqdn}.pem"
    fi
}

if [[ $# != 1 ]]; then
    show_usage_and_exit
fi
TARGET_DIR="$1"

# Create certs
create_root_cert "${TARGET_DIR}/ca-private"
create_machine_cert "${TARGET_DIR}/ca-private" "${TARGET_DIR}/proxy" "ldap-ui.proxy.auth-demo.docker"
create_machine_cert "${TARGET_DIR}/ca-private" "${TARGET_DIR}/proxy" "keycloak.proxy.auth-demo.docker"
create_machine_cert "${TARGET_DIR}/ca-private" "${TARGET_DIR}/proxy" "crowd.proxy.auth-demo.docker"
create_machine_cert "${TARGET_DIR}/ca-private" "${TARGET_DIR}/proxy" "bitbucket.proxy.auth-demo.docker"
create_machine_cert "${TARGET_DIR}/ca-private" "${TARGET_DIR}/proxy" "jira.proxy.auth-demo.docker"
create_machine_cert "${TARGET_DIR}/ca-private" "${TARGET_DIR}/proxy" "artifactory.proxy.auth-demo.docker"

# Share the CA cert with all machines
cp "${TARGET_DIR}/ca-private/root-ca.crt" "${TARGET_DIR}/ca-shared/root-ca.crt"

# Generate a Java truststore that includes our the CA
cp /etc/ssl/certs/java/cacerts "${TARGET_DIR}/ca-shared/cacerts.jks"
keytool -import -noprompt \
  -file "${TARGET_DIR}/ca-shared/root-ca.crt" \
  -alias Root-Auth-Demo \
  -keystore "${TARGET_DIR}/ca-shared/cacerts.jks" \
  -storepass changeit

# Change ownership to match the UID:GID of containers (making key files readable)
find "${TARGET_DIR}/proxy" -type f -exec chown '99:99' {} \;

echo "==== SUCCESS ===="
