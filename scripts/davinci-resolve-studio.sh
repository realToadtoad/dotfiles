#!/usr/bin/env bash

cd /tmp
git clone https://aur.archlinux.org/davinci-resolve-studio.git
cd davinci-resolve-studio
git checkout 1bcae663bb61c07e6fc0f8c89c6df2891f4a2af3
sudo pacman -S libxcrypt-compat pulseaudio-alsa

echo "Go to https://www.blackmagicdesign.com/support/download/7e8656e2d76240ef8923609655d70fb6/Linux and drop the downloaded file to /tmp/davinci-resolve-studio. Press a key when you're done."
read

makepkg -si

echo "Resolve 16 now installed. Open it and input your license key. Then close it. Press a key when you're done."
read

sudo pacman -R davinci-resolve-studio
git checkout master
makepkg -si
