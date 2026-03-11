#!/bin/bash
echo "OpenHabitat Setup"

# Create .env if it doesn't exist
if [ ! -f .env ]; then
    cp .env.example .env
    echo "Created .env from .env.example - fill in your credentials"
fi

# Create Mosquitto passwd file
echo "Creating Mosquitto user (enter password when prompted):"
docker run --rm -it -v $(pwd)/config/mosquitto:/mosquitto/config eclipse-mosquitto:2 \
    mosquitto_passwd -c /mosquitto/config/passwd openhabitat

echo "Setup complete, run: docker compose up -d"
