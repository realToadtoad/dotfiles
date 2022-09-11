#!/usr/bin/env bash

cd /tmp
git clone https://aur.archlinux.org/davinci-resolve-studio.git
cd davinci-resolve-studio
git checkout 1bcae663bb61c07e6fc0f8c89c6df2891f4a2af3
makepkg -si
sudo pacman -S libxcrypt-compat pulseaudio-alsa

echo "Resolve 16 now installed. Open it and input your license key. Then close it. Press a key when you're done."
read

sudo pacman -R davinci-resolve-studio
git checkout master
makepkg -si
