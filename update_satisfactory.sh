#!/bin/bash

# Variables
USER="satisfactory"
INSTALL_DIR="/home/$USER/satisfactory"
STEAMCMD_DIR="/home/$USER/steamcmd"
GAME_ID="1690800"

# Update the Satisfactory server via SteamCMD
echo "Updating Satisfactory server..."
sudo -u $USER bash -c "$STEAMCMD_DIR/steamcmd.sh +login anonymous +force_install_dir $INSTALL_DIR +app_update $GAME_ID validate +quit"

# Restart the server after the update
echo "Restarting Satisfactory server..."
sudo systemctl restart satisfactory

echo "Server update and restart completed."
