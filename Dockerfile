FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        libssl3 \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r beammp && useradd -r -g beammp -d /beammp -s /bin/sh beammp

WORKDIR /beammp

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p Resources/Client Resources/Server \
    && chown -R beammp:beammp /beammp

USER beammp

EXPOSE 30814/tcp
EXPOSE 30814/udp

ENTRYPOINT ["/entrypoint.sh"]
