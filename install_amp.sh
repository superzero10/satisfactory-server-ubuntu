#!/bin/bash

# Variables
DOMAIN="your_domain.com"  # Replace with your domain
EMAIL="your_email@example.com"  # Replace with your email address
USER="amp"  # User for AMP

# 1. Install prerequisites
echo "Updating system and installing prerequisites..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl gnupg apt-transport-https software-properties-common

# 2. Download and install AMP
echo "Downloading and installing AMP..."
curl -O https://cubecoders.com/Downloads/ampinstmgr.sh
chmod +x ampinstmgr.sh
sudo ./ampinstmgr.sh

# 3. Create an AMP instance for Satisfactory
echo "Creating an AMP instance for Satisfactory..."
sudo ampinstmgr CreateInstance SatisfactoryInstance "Satisfactory" 0.0.0.0 8080 +Core.Login.Username $USER +Core.Login.Password "password" +Core.System.Translations.Default "en-US"

# 4. Start the Satisfactory instance
echo "Starting the Satisfactory instance..."
sudo ampinstmgr StartInstance SatisfactoryInstance

# 5. Install Certbot for SSL (optional but recommended)
echo "Installing Certbot and obtaining SSL certificate..."
sudo apt install -y certbot
sudo certbot certonly --standalone -d $DOMAIN -m $EMAIL --agree-tos --non-interactive

# 6. Configure AMP to use SSL (manual via web interface)
echo "Configure SSL in AMP via the web interface."

# 7. Configure the firewall for AMP
echo "Configuring the firewall..."
sudo ufw allow 8080/tcp  # Port for the AMP web interface
sudo ufw reload

echo "AMP installation completed. Access the interface at http://$DOMAIN:8080"
