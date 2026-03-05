#!/bin/sh
set -e

CONFIG=/beammp/ServerConfig.toml
BINARY=/beammp/BeamMP-Server
DOWNLOAD_URL="https://github.com/BeamMP/BeamMP-Server/releases/latest/download/BeamMP-Server.debian.12.x86_64"

echo "[entrypoint] Downloading latest BeamMP-Server..."
curl -fsSL "$DOWNLOAD_URL" -o "$BINARY"
chmod +x "$BINARY"
echo "[entrypoint] Download complete."

if [ ! -f "$CONFIG" ]; then
    echo "[entrypoint] No ServerConfig.toml found — generating default config..."
    cat > "$CONFIG" << 'EOF'
[General]
# Server name shown in the in-game server browser
Name = "BeamMP Server"

# Port to listen on (TCP + UDP). Must be forwarded on your router/firewall.
Port = 30814

# Maximum number of players allowed at once
MaxPlayers = 8

# Maximum number of vehicles per player (0 = unlimited)
MaxCars = 1

# Map to load. Uses BeamNG.drive level paths.
# Common maps:
#   /levels/gridmap_v2/info.json
#   /levels/small_island/info.json
#   /levels/italy/info.json
#   /levels/west_coast_usa/info.json
#   /levels/johnson_valley/info.json
#   /levels/derby/info.json
#   /levels/driver_training/info.json
Map = "/levels/gridmap_v2/info.json"

# Short description shown in the server browser
Description = "A private BeamMP server"

# Comma-separated tags for filtering (e.g. "Freeroam,Casual")
Tags = "Freeroam"

# Enable verbose debug logging
Debug = false

# true  = server is private (not listed publicly, invite via direct IP)
# false = server is listed in the public browser
Private = true

# Log player chat to server console/log file
LogChat = true

# Path to the resources folder (relative to working directory)
ResourceFolder = "Resources"

# Authentication key — required to run the server.
# Get yours at: https://beammp.com/keymaster
AuthKey = ""

[Misc]
# Send anonymous error/crash reports to BeamMP developers
SendErrors = true

# Show a message in-game when an error report is sent
SendErrorsShowMessage = true

# Disable the built-in BeamMP update checker
ImScaredOfUpdates = false
EOF
    echo ""
    echo "================================================================"
    echo "  Config generated at: ./data/ServerConfig.toml"
    echo ""
    echo "  1. Open ./data/ServerConfig.toml"
    echo "  2. Set your AuthKey (get one at https://beammp.com/keymaster)"
    echo "  3. Adjust any other settings"
    echo "  4. Run: podman compose up (or docker compose up)"
    echo "================================================================"
    echo ""
    exit 0
fi

mkdir -p Resources/Client Resources/Server

exec "$BINARY"
