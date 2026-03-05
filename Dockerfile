FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        libssl3 \
        liblua5.3-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /beammp

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 30814/tcp
EXPOSE 30814/udp

ENTRYPOINT ["/entrypoint.sh"]
