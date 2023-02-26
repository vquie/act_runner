# build
FROM --platform=linux/amd64 golang:1.20.1 AS builder

RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://gitea.com/gitea/act_runner.git /opt/act_runner

WORKDIR /opt/act_runner

RUN make build

# final image
FROM --platform=linux/amd64 debian:11.6-slim

RUN apt-get update && apt-get install -y \
    ca-certificates \
    docker \
    && rm -rf /var/lib/apt/lists/*

ARG VERSION
ENV VERSION ${VERSION}

COPY --from=builder /opt/act_runner/act_runner /usr/local/bin/act_runner

COPY ./rootfs /

RUN chmod -R 0755 /usr/local/*

RUN mkdir /opt/act_runner

WORKDIR /opt/act_runner

ENTRYPOINT ["/usr/local/bin/act-runner-entrypoint.sh"]
