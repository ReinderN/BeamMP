#!/bin/sh
set -e

BINARY=/usr/local/bin/BeamMP-Server
DOWNLOAD_URL="https://github.com/BeamMP/BeamMP-Server/releases/latest/download/BeamMP-Server"

echo "[entrypoint] Downloading latest BeamMP-Server..."
curl -fsSL "$DOWNLOAD_URL" -o "$BINARY"
chmod +x "$BINARY"
echo "[entrypoint] Download complete."

# Ensure resource directories exist (may be bind-mounted as a directory)
mkdir -p Resources/Client Resources/Server

exec "$BINARY"
