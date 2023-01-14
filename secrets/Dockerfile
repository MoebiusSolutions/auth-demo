FROM ubuntu:latest

RUN set -x && \
    apt -y update && \
    # gettext provides envsubst
    apt -y install gettext && \
    rm -rf /var/lib/apt/lists/*

ADD --chown=root:root entrypoint-secrets.sh /opt/secrets/
ADD --chown=root:root show-secrets.sh /opt/secrets/
ADD --chown=root:root words_3000.txt /opt/secrets/

RUN set -x && \
    chown root:root /opt/secrets && \
    chmod 0755 /opt/secrets/entrypoint-secrets.sh && \
    chmod 0755 /opt/secrets/show-secrets.sh && \
    chmod 0644 /opt/secrets/words_3000.txt

CMD ["/bin/bash", "/opt/secrets/entrypoint-secrets.sh"]