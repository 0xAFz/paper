#!/bin/bash

paper_path="$(pwd)/paper"

# Check if the paper file exists
if [ -f "$paper_path" ]; then
    # Create the .paper directory if it does not exist
    if [ ! -e "$HOME/.paper" ]; then
        mkdir -p "$HOME/.paper"
    fi

    # Copy the paper file to the .paper directory if it does not exist
    if [ ! -e "$HOME/.paper/paper" ]; then
        cp "$paper_path" "$HOME/.paper"
    fi
else
    echo "Paper does not exist."
    exit 1
fi

# Create the service file content
service_content=$(cat <<EOF
[Unit]
Description=Paper script service

[Service]
User=$(whoami)
Environment=DISPLAY=:0
ExecStart=/usr/bin/bash "$HOME/.paper/paper"

[Install]
WantedBy=multi-user.target
EOF
)

# Write the service file to /etc/systemd/system
echo -e "$service_content" | sudo tee /etc/systemd/system/paper.service > /dev/null

# Create the timer file content
timer_content=$(cat <<EOF
[Unit]
Description=Cronjob for paper script

[Timer]
OnBootSec=1min
OnUnitActiveSec=1min
Unit=paper.service

[Install]
WantedBy=timers.target
EOF
)

# Write the timer file to /etc/systemd/system
echo -e "$timer_content" | sudo tee /etc/systemd/system/paper.timer > /dev/null

# Reload systemd to recognize the new service and timer
sudo systemctl daemon-reload

# Enable and start the timer
sudo systemctl enable --now paper.timer

echo -e "Installation complete.\nThe paper script service and timer have been set up."

