# Paper

## Overview

The **Paper** is a bash-based utility that allows users to change their desktop wallpaper at specified intervals using **Feh**, a lightweight wallpaper manager. The script can be configured to use a default directory for wallpapers or a user-specified directory. It also sets up a systemd timer to automate the wallpaper changing process.

## Prerequisites

- **Feh**: Ensure that feh is installed on your system. You can install it using your package manager.
- **Systemd**: This script utilizes systemd for scheduling, so ensure your system uses systemd as the init system.

#### Usage

To run the wallpaper changer manually, you can execute:

```bash
bash paper [custom_wallpaper_directory]
```

- `custom_wallpaper_directory` (optional): Specify a directory containing wallpapers. If provided, it will override the default path (`$HOME/Pictures`).

#### Install

To install the wallpaper changer and set up the timer, run:

```bash
bash install.sh
```

### Configuration

- The timer is configured to run the wallpaper changer every minute after boot (`OnBootSec=1min` and `OnUnitActiveSec=1min`). 
- You can modify these values in the `install.sh` script under the timer configuration section.

### Uninstallation
```bash
sudo systemctl disable --now paper.timer
sudo rm /etc/systemd/system/paper.timer
sudo rm /etc/systemd/system/paper.service
rm -rf $HOME/.paper
```

## Additional Notes

- You can adjust the script to specify different display environments if you are using multiple displays.
- Ensure that your `DISPLAY` environment variable is correctly set in the service file or dynamically in the wallpaper script.

