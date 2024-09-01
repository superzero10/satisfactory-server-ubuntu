#!/bin/bash

# Variables
USER="satisfactory"
INSTALL_DIR="/home/$USER/satisfactory"
BACKUP_DIR="/home/$USER/satisfactory_backups"
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
BACKUP_FILE="$BACKUP_DIR/satisfactory_backup_$TIMESTAMP.tar.gz"

# Create the backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Perform the backup
echo "Creating backup: $BACKUP_FILE"
tar -czvf $BACKUP_FILE -C $INSTALL_DIR .

# Delete backups older than 7 days
echo "Cleaning up old backups..."
find $BACKUP_DIR -type f -mtime +7 -exec rm {} \;

echo "Backup completed: $BACKUP_FILE"
