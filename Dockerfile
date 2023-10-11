FROM debian:11.8-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl && \
    curl -fsSL get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG VERSION

RUN curl -fsSL "https://gitea.com/gitea/act_runner/releases/download/v${VERSION}/act_runner-${VERSION}-linux-amd64" -o /usr/local/bin/act_runner

COPY ./rootfs /

RUN chmod -R 0755 /usr/local/bin/*

RUN mkdir /opt/act_runner

WORKDIR /opt/act_runner

ENTRYPOINT ["/usr/local/bin/act-runner-entrypoint.sh"]
