ARG TARGETARCH
ARG BUILDPLATFORM
ARG VERSION

FROM --platform=${BUILDPLATFORM} debian:11.6-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget && \
    curl -fsSL get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -fsSL https://gitea.com/gitea/act_runner/releases/download/v${ACT_RUNNER_VERSION}/act_runner-${ACT_RUNNER_VERSION}-linux-${TARGETARCH} -o /usr/local/bin/act_runner

COPY ./rootfs /

RUN chmod -R 0755 /usr/local/bin/*

RUN mkdir /opt/act_runner

WORKDIR /opt/act_runner

ENTRYPOINT ["/usr/local/bin/act-runner-entrypoint.sh"]
