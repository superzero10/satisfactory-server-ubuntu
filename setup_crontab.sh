#!/bin/bash

# Script to set up crontab for Satisfactory Server maintenance tasks

# Variables
BACKUP_SCRIPT="/home/satisfactory/backup_satisfactory.sh"
UPDATE_SCRIPT="/home/satisfactory/update_satisfactory.sh"
RESTART_SCRIPT="/home/satisfactory/restart_satisfactory.sh"

# Create a temporary file for crontab
temp_crontab=$(mktemp)

# Load current crontab into the temporary file
crontab -l > "$temp_crontab"

# Function to add a cron job if it doesn't exist
add_cron_job() {
    local cron_time="$1"
    local command="$2"
    
    if ! grep -Fxq "$cron_time $command" "$temp_crontab"; then
        echo "$cron_time $command" >> "$temp_crontab"
        echo "Added cron job: $cron_time $command"
    else
        echo "Cron job already exists: $cron_time $command"
    fi
}

# Add cron jobs for backup, update, and restart
add_cron_job "0 4 * * *" "$BACKUP_SCRIPT"
add_cron_job "0 3 * * *" "$UPDATE_SCRIPT"
add_cron_job "0 5 * * *" "$RESTART_SCRIPT"

# Install the new crontab from the temporary file
crontab "$temp_crontab"

# Clean up the temporary file
rm "$temp_crontab"

echo "Crontab setup completed."
