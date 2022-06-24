#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

echo "Installing Chaotic-AUR primary key..." # last updated 2022-06-23
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
echo "Installing chaotic-keyring and chaotic-mirrorlist..."
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm
echo "Adding chaotic-aur to /etc/pacman.conf..."
if grep -q "\[chaotic-aur\]" /etc/pacman.conf
then
  echo "Already added."
else
  echo "" | sudo tee -a /etc/pacman.conf
  echo "[chaotic-aur]" | sudo tee -a /etc/pacman.conf
  echo "Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
fi
