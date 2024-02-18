FROM ubuntu:22.04

RUN set -x && \
    apt -y update && \
    apt -y install curl && \
    rm -rf /var/lib/apt/lists/*

ADD --chown=root:root entrypoint.sh /entrypoint.sh

RUN set -x && \
    chmod 0755 /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
