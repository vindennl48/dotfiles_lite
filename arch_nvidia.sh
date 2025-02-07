#!/bin/bash

# NVIDIA Driver Install Script for Arch Linux (Supports GRUB and systemd-boot)

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

# Install NVIDIA packages
pacman -Sy --noconfirm nvidia nvidia-utils lib32-nvidia-utils nvidia-settings

# Configure kernel parameters for both GRUB and systemd-boot
configure_bootloader() {
    local param="nvidia-drm.modeset=1"
    
    # GRUB Configuration
    if [ -f /etc/default/grub ]; then
        echo "Configuring GRUB..."
        if ! grep -q "$param" /etc/default/grub; then
            sed -i "s/^\(GRUB_CMDLINE_LINUX_DEFAULT=\"[^\"]*\)\"/\1 $param\"/" /etc/default/grub
            grub-mkconfig -o /boot/grub/grub.cfg
        fi
    fi

    # systemd-boot Configuration
    if [ -d /boot/loader/entries/ ] && ls /boot/loader/entries/*.conf >/dev/null 2>&1; then
        echo "Configuring systemd-boot..."
        for entry in /boot/loader/entries/*.conf; do
            if ! grep -q "$param" "$entry"; then
                sed -i "s/^options \(.*\)/options \1 $param/" "$entry"
                echo "Updated: $entry"
            fi
        done
    fi
}

# Run bootloader configuration
configure_bootloader

# Regenerate initramfs
echo "Regenerating initramfs..."
mkinitcpio -P

echo ""
echo "Installation complete!"
echo "Please REBOOT your system and verify with:"
echo "1. nvidia-smi (should show GPU info)"
echo "2. glxinfo | grep -i \"opengl renderer\" (should show NVIDIA GPU)"
echo ""
echo "Note: Both GRUB and systemd-boot configurations were checked/updated"
