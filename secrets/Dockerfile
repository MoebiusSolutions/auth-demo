FROM ubuntu:23.04

RUN set -x && \
    # NOTE: slapd install prompts for passwd without DEBIAN_FRONTEND setting
    export DEBIAN_FRONTEND=noninteractiv && \
    apt -y update && \
    apt -y install \
        # Provides envsubst, which is used to replace environment variables in config files
        gettext \
        # Provides slappasswd, which is used for encoding ldap passwords
        slapd \
        # Provides the JDK system certifiate store (which gives us a store to append our self-signed CA to)
        openjdk-11-jdk-headless && \
    rm -rf /var/lib/apt/lists/*

ADD --chown=root:root entrypoint-secrets.sh /opt/secrets/
ADD --chown=root:root gen-certs.sh /opt/secrets/
ADD --chown=root:root show-secrets.sh /opt/secrets/
ADD --chown=root:root words_3000.txt /opt/secrets/

RUN set -x && \
    chown root:root /opt/secrets && \
    chmod 0755 /opt/secrets/entrypoint-secrets.sh && \
    chmod 0755 /opt/secrets/gen-certs.sh && \
    chmod 0755 /opt/secrets/show-secrets.sh && \
    chmod 0644 /opt/secrets/words_3000.txt

CMD ["/bin/bash", "/opt/secrets/entrypoint-secrets.sh"]
