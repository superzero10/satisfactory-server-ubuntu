#!/bin/bash

# Variables
USER="satisfactory"
INSTALL_DIR="/home/$USER/satisfactory"
STEAMCMD_DIR="/home/$USER/steamcmd"
STEAMCMD_URL="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
GAME_ID="1690800"  # Satisfactory server game ID

# 1. Update the system and install necessary dependencies
echo "Updating system and installing dependencies..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y lib32gcc-s1 lib32stdc++6 curl tar wget ufw fail2ban

# 2. Create a dedicated user
echo "Creating dedicated user $USER..."
sudo useradd -m -s /bin/bash $USER

# 3. Install SteamCMD
echo "Installing SteamCMD..."
mkdir -p $STEAMCMD_DIR
cd $STEAMCMD_DIR
wget $STEAMCMD_URL
tar -xvzf steamcmd_linux.tar.gz
sudo chown -R $USER:$USER $STEAMCMD_DIR

# 4. Download and install the Satisfactory server
echo "Downloading and installing the Satisfactory server..."
sudo -u $USER bash -c "$STEAMCMD_DIR/steamcmd.sh +login anonymous +force_install_dir $INSTALL_DIR +app_update $GAME_ID validate +quit"

# 5. Configure systemd service to manage the Satisfactory server
echo "Configuring systemd service for the Satisfactory server..."
cat <<EOL | sudo tee /etc/systemd/system/satisfactory.service
[Unit]
Description=Satisfactory Server
After=network.target

[Service]
Type=simple
User=$USER
ExecStart=$INSTALL_DIR/FactoryServer.sh -ServerQueryPort=15777 -multihome=0.0.0.0
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload
sudo systemctl enable satisfactory
sudo systemctl start satisfactory

# 6. Configure the firewall with UFW
echo "Configuring the firewall..."
sudo ufw allow OpenSSH
sudo ufw allow 15777/udp  # Satisfactory server port
sudo ufw enable

# 7. Set up Fail2Ban for security
echo "Setting up Fail2Ban..."
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# 8. Configure logrotate for server logs
echo "Configuring logrotate for server logs..."
cat <<EOL | sudo tee /etc/logrotate.d/satisfactory
$INSTALL_DIR/FactoryGame/Saved/Logs/*.log {
    daily
    rotate 7
    compress
    missingok
    notifempty
    create 0640 $USER $USER
}
EOL

echo "Satisfactory server installation and configuration completed."
