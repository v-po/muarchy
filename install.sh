#!/usr/bin/env bash
set -euo pipefail

echo "Muarchy Installing base packages and configs..."

# Update system
sudo pacman -Syu --noconfirm

# Install core packages
sudo pacman -S --needed --noconfirm $(< ~/.local/share/muarchy/system.packages)

# Example AUR helper install (yay)
if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay-bin.git /tmp/yay
  pushd /tmp/yay
  makepkg -si --noconfirm
  popd
fi

mkdir -p ~/.config
cp -R ~/.local/share/muarchy/config/* ~/.config/


systemctl enable sddm.service

echo "Muarchy All set!"
