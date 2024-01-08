#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./remove_apps.sh" 2>&1
  exit 1
fi

# List of packages to remove
packages_to_remove=(
  steam lutris gimp inkscape kdenlive audacity libreoffice
  onlyoffice planner hexchat thunderbird pidgin transmission
  manjaro-settings-manager octopi pamac xfce4-terminal mousepad
  xfburn parole audacious
)

# Remove packages
echo "Removing selected packages..."
pacman -Rns --noconfirm "${packages_to_remove[@]}"

# Keep GParted and VLC
echo "Keeping GParted and VLC..."
pacman -Rns --noconfirm gparted vlc

echo "Cleanup and update system..."
# Clean up orphaned packages
pacman -Rns --noconfirm $(pacman -Qdtq)

# Update system
pacman -Syu --noconfirm

echo "Removal complete."
