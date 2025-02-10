#!/bin/bash

# SSH Install Script for Arch Linux

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

echo "Installing SSH..."
pacman -Sy openssh

# comment out KbdInteractiveAuthentication in /etc/ssh/sshd_config
read -p "--> Make sure to comment out KbdInteractiveAuthentication in /etc/ssh/sshd_config" ans
vim /etc/ssh/sshd_config

echo "Enabling and starting SSH service..."
systemctl enable sshd.service && systemctl start sshd.service
