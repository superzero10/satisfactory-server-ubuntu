
# 🚀 Satisfactory Server Setup with AMP on Ubuntu

This repository contains a series of scripts to **install**, **configure**, and **manage** a Satisfactory server on Ubuntu. The scripts are designed to be **simple**, **automated**, and **easy to use**.

## 🗂 Script Overview

| Script Name                    | Description                                                              |
| ------------------------------ | ------------------------------------------------------------------------ |
| `install_satisfactory_server.sh` | Main script to install the Satisfactory server and configure dependencies. |
| `backup_satisfactory.sh`        | Script to perform daily backups of the server.                           |
| `update_satisfactory.sh`        | Script to automate the daily update of the Satisfactory server.          |
| `restart_satisfactory.sh`       | Script to automatically restart the server every day.                    |
| `install_amp.sh`                | Script to install and configure AMP (Application Management Panel).      |
| `setup_crontab.sh`              | Script to set up the crontab for automated tasks (backups, updates, restarts). |

## 📋 Prerequisites

- A fresh Ubuntu installation.
- Root or sudo access to install packages and configure services.
- Internet access to download the necessary dependencies and files.

## 🛠️ Installation Instructions

### 1. Install the Satisfactory Server

Run the main script to install and configure the Satisfactory server.

```bash
sudo bash install_satisfactory_server.sh
```

This script performs the following operations:
- Updates the system.
- Installs the necessary dependencies (SteamCMD, UFW, Fail2Ban, etc.).
- Creates a dedicated user for the server.
- Installs the Satisfactory server via SteamCMD.
- Configures systemd services to manage the server.
- Configures security with UFW and Fail2Ban.
- Sets up logrotate to manage server logs.

### 2. Set Up Automated Backups

The `backup_satisfactory.sh` script creates daily backups of the server and deletes backups older than 7 days.

To automate this task, add it to `cron` using the `setup_crontab.sh` script:

```bash
sudo bash setup_crontab.sh
```

This will schedule the backup script to run daily at 4 AM.

### 3. Automate Daily Updates

The `update_satisfactory.sh` script checks for and applies server updates via SteamCMD, then restarts the server.

This is also set up using the `setup_crontab.sh` script, which schedules it to run daily at 3 AM.

### 4. Automate Daily Restarts

The `restart_satisfactory.sh` script restarts the server daily to maintain optimal performance.

This is also configured via the `setup_crontab.sh` script to run daily at 5 AM.

### 5. Install the Web Interface (AMP)

To install and configure AMP to manage your Satisfactory server, run the following script:

```bash
sudo bash install_amp.sh
```

This script:
- Installs the prerequisites for AMP.
- Downloads and installs AMP.
- Creates an AMP instance for Satisfactory.
- Configures a firewall to allow access to the AMP web interface.
- (Optional) Configures SSL with Certbot to secure the interface.

After installation, access the AMP interface at `http://your_domain.com:8080`.

### 6. Verify and Test Your Setup

Ensure everything is set up correctly:

- **Check Satisfactory Server Status**:
  ```bash
  sudo systemctl status satisfactory
  ```

- **Check AMP Status**:
  ```bash
  sudo systemctl status ampinstmgr@SatisfactoryInstance
  ```

## 🔒 Services and Security Configuration

- **UFW**: Ensure that the UFW firewall is enabled and configured to allow necessary ports.
- **Fail2Ban**: Fail2Ban is configured to protect against unauthorized login attempts.

## ⚙️ Management and Maintenance

### Main Commands

- **Start the server**:
  ```bash
  sudo systemctl start satisfactory
  ```

- **Stop the server**:
  ```bash
  sudo systemctl stop satisfactory
  ```

- **Restart the server**:
  ```bash
  sudo systemctl restart satisfactory
  ```

- **Check server status**:
  ```bash
  sudo systemctl status satisfactory
  ```

### Backups

Backups are stored in `/home/satisfactory/satisfactory_backups/` and are performed daily, with backups older than 7 days being deleted.

### Updates

The server is automatically updated via the `update_satisfactory.sh` script, which runs daily.

### Restart

The server is automatically restarted daily via the `restart_satisfactory.sh` script, which runs every day at 5 AM.

## 📝 Final Remarks

These scripts are designed to make managing a Satisfactory server on Ubuntu easy and efficient, while using AMP for a powerful and intuitive web interface. They can be adapted to meet specific needs. For any questions or suggestions for improvement, feel free to contact me.

---

Enjoy your gaming experience with a fully automated and secure Satisfactory server via AMP! 🎮
