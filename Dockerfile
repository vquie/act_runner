FROM --platform=linux/amd64 debian:11.6-slim

ARG VERSION
ENV VERSION ${VERSION}

COPY ./rootfs /

RUN chmod -R 0755 /opt/script/*

CMD ["/opt/script/script.sh"]